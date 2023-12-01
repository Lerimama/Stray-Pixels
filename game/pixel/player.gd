extends KinematicBody2D


signal stat_changed (stat_owner, event, stat_change)

enum States {IDLE, STEPPING, SKILLED, SKILLING, COCKING, RELEASING, BURSTING}
var current_state # = States.IDLE

export var pixel_color: Color # exportano za animacijo "become_white"

var direction = Vector2.ZERO # prenosna
var collision: KinematicCollision2D
var step_time: float # uporabi se pri step tweenu in je nekonstanten, če je "energy_speed_mode"
var skill_sfx_playing: bool = false #  lahko kličem is procesne funkcije
var player_energy: float # player jo pozna samo zaradi spreminjanja obnašanja
var player_camera: Node
var player_camera_target: Node

# push & pull
var pull_time: float = 0.3
var pull_cell_count: int = 1
var push_time: float = 0.3
var push_cell_count: int = 1

# teleport
var backup_time: float = 0.32
var ghost_max_speed: float = 10

# cocking
var cocked_ghosts: Array
var cocking_room: bool = true
var cocked_ghost_count_max: int = 7
var cocked_ghost_alpha: float = 0.55 # najnižji alfa za ghoste
var cocked_ghost_alpha_divisor: float = 14 # faktor nižanja po zaporedju (manjši je bolj oster
var ghost_cocking_time: float = 0 # trenuten čas nastajanja cocking ghosta
var ghost_cocking_time_limit: float = 0.12 # max čas nastajanja cocking ghosta (tudi animacija)
var cocked_ghost_fill_time: float = 0.04 # čas za napolnitev vseh spawnanih ghostov (tik pred burstom)
var cocked_pause_time: float = 0.05 # čas za napolnitev vseh spawnanih ghostov (tik pred burstom)

# bursting
var burst_speed: float = 0 # glavna (trenutna) hitrost
var burst_speed_max: float = 0 # maximalna hitrost v tweenu (določena med kokanjem)
var burst_speed_addon: float = 12
var strech_ghost_shrink_time: float = 0.2
var burst_direction_set: bool = false
#var burst_power: int # moč v številu ghosts_count
var burst_cocked_ghost_count: int # moč v številu ghosts_count
var burst_velocity: Vector2

# shaking camera
var burst_power_shake_addon: float = 0.03
var hit_wall_shake_power: float = 0.25
var hit_wall_shake_time: float = 0.5
var hit_wall_shake_decay: float = 0.2
var hit_stray_shake_power: float = 0.2
var hit_stray_shake_time: float = 0.3
var hit_stray_shake_decay: float = 0.7
var die_shake_power: float = 0.2
var die_shake_time: float = 0.7
var die_shake_decay: float = 0.1

# player settings

var max_player_energy: float = Global.game_manager.game_settings["player_max_energy"]
var step_time_slow: float = Global.game_manager.game_settings["step_time_slow"]
var step_time_fast: float = Global.game_manager.game_settings["step_time_fast"]
var slowdown_rate: int = Global.game_manager.game_settings["slowdown_rate"] # višja je, počasneje se manjša

# heartbeat
var heartbeat_active: bool = false 
var heartbeat_loop: int = 0
var has_no_energy: bool

# controls
var key_left: String
var key_right: String
var key_up: String
var key_down: String
var key_burst: String

onready var cell_size_x: int = Global.game_tilemap.cell_size.x  # pogreba od GMja, ki jo dobi od tilemapa
onready var animation_player: AnimationPlayer = $AnimationPlayer
onready var vision_ray: RayCast2D = $VisionRay
onready var collision_shape: CollisionShape2D = $CollisionShape2D
onready var Ghost: PackedScene = preload("res://game/pixel/ghost.tscn")
onready var PixelCollisionParticles: PackedScene = preload("res://game/pixel/pixel_collision_particles.tscn")
onready var PixelDizzyParticles: PackedScene = preload("res://game/pixel/pixel_dizzy_particles.tscn")
onready var glow_light: Light2D = $GlowLight
onready var skill_light: Light2D = $SkillLight

# NEU
var is_virgin: bool = true # začne kot devičnik ... neha bit na prvi end_move ali na začetku cockanja
# statistika
var player_stats: Dictionary = Profiles.default_player_stats.duplicate() # tukaj se postavijo prazne vrednosti, ki se nafilajo kasneje


func _ready() -> void:
	
	randomize() # za random blink animacije
	add_to_group(Global.group_players)

	# controls setup
	if Global.game_manager.game_settings["start_players_count"] == 2:
		key_left = "%s_left" % name
		key_right = "%s_right" % name
		key_up = "%s_up" % name
		key_down = "%s_down" % name
		key_burst = "%s_burst" % name
	else:
		key_left = "ui_left"
		key_right = "ui_right"
		key_up = "ui_up"
		key_down = "ui_down"
		key_burst = "burst"
	
	modulate = pixel_color # pixel_color je določen ob spawnu z GM
	skill_light.enabled = false
	glow_light.enabled = false
	current_state = States.IDLE

	
func _physics_process(delta: float) -> void:
			
	state_machine()
	
	# heartbeat
	if player_energy <= 1:
		has_no_energy = true
	else:
		has_no_energy = false
	if not heartbeat_active and has_no_energy:
		heartbeat_active = true
		heartbeat_loop = 0
		animation_player.play("heartbeat")		
	elif heartbeat_active and not has_no_energy:
		heartbeat_active = false
		animation_player.stop()
	
 
func state_machine():
	
	match current_state:
		States.IDLE:
			if Global.detect_collision_in_direction(vision_ray, direction): # koda je tukaj, da ne blinkne ob kontaktu s sosedo
				current_state = States.SKILLED
			# toggle energy_speed_mode
			if Global.game_manager.game_settings["slowdown_mode"]:
				var slow_trim_size: float = step_time_slow * max_player_energy
				var energy_factor: float = (max_player_energy - slow_trim_size) / player_energy
				var energy_step_time = energy_factor / slowdown_rate # variabla, da FP ne kliče na vsak frejm
				step_time = clamp(energy_step_time, step_time_fast, step_time_slow) # omejim najbolj počasno korakanje
			else:
				step_time = step_time_fast
			idle_inputs()
		States.SKILLED:
			skill_inputs()
			if not skill_light.enabled:
				skill_light_on()
		States.COCKING:
			cocking_inputs()
		States.BURSTING:
			burst_velocity = direction * burst_speed
			collision = move_and_collide(burst_velocity) 
			if collision:
				on_collision()
			bursting_inputs()

	
func on_collision(): 
	
	Global.sound_manager.stop_sfx("burst")
	
	# shake calc
	var added_shake_power = hit_stray_shake_power + burst_power_shake_addon * burst_cocked_ghost_count
	var added_shake_time = hit_stray_shake_time + burst_power_shake_addon * burst_cocked_ghost_count
	
	if collision.collider.is_in_group(Global.group_tilemap):
		if heartbeat_active: # enako, kot,da bi bil zadnji bit ... kar umre, da se ne animacija ne meša z revive
			heartbeat_active = false
			glow_light.enabled = false
			emit_signal("stat_changed", self, "out_of_energy", 1)
		else:
			emit_signal("stat_changed", self, "hit_wall", 1)
		die()
		end_move()
		# efekti
		Input.start_joy_vibration(0, 0.5, 0.6, 0.7)
		Global.sound_manager.play_sfx("hit_wall")
		player_camera.shake_camera(added_shake_power, added_shake_time, hit_stray_shake_decay)
		spawn_dizzy_particles()
		spawn_collision_particles()
		
	elif collision.collider.is_in_group(Global.group_strays):
		on_hit_stray(collision.collider)
		end_move()
		# efekti
		Input.start_joy_vibration(0, 0.5, 0.6, 0.2)
		Global.sound_manager.play_sfx("hit_stray")	
		player_camera.shake_camera(added_shake_power, added_shake_time, hit_stray_shake_decay)
		spawn_collision_particles()
	
	elif collision.collider.is_in_group(Global.group_players):
		var hit_player: KinematicBody2D = collision.collider
		var player_direction = direction # za korekcijo
		# zmaga
		if burst_speed > hit_player.burst_speed:
			if hit_player.pixel_color != Global.game_manager.game_settings["player_start_color"]: # če nima nobene barve mu je ne prevzamem
				pixel_color = hit_player.pixel_color # prevzamem barvo
			emit_signal("stat_changed", self, "hit_player", 1) # vzamem mu pobrane barve
			hit_player.on_get_hit(added_shake_power, added_shake_time)
			end_move()
			hit_player.end_move() # plejer, ki prvi zazna kontakt ukaže naprej, da je zaporedje pod kontrolo 
			# efekti
			Input.start_joy_vibration(0, 0.5, 0.6, 0.2)
			Global.sound_manager.play_sfx("hit_stray")	
			player_camera.shake_camera(added_shake_power, added_shake_time, hit_stray_shake_decay)
			spawn_collision_particles()
		# neodločeno
		elif burst_speed_max == hit_player.burst_speed:
			end_move()
			hit_player.end_move() # plejer, ki prvi zazna kontakt ukaže naprej, da je zaporedje pod kontrolo 
			# efekti
			Input.start_joy_vibration(0, 0.5, 0.6, 0.2)
			Global.sound_manager.play_sfx("hit_stray")
			player_camera.shake_camera(added_shake_power, added_shake_time, hit_stray_shake_decay)
			spawn_collision_particles()
		# korekcija, če končata na isti poziciji ali preveč narazen
		global_position = hit_player.global_position + (cell_size_x * (- player_direction)) # plejer eno polje ob zadetem
	

# INPUTS ------------------------------------------------------------------------------------------


func idle_inputs():
	
	if Input.is_action_pressed(key_up):
		direction = Vector2.UP
		step()
	elif Input.is_action_pressed(key_down):
		direction = Vector2.DOWN
		step()
	elif Input.is_action_pressed(key_left):
		direction = Vector2.LEFT
		step()
	elif Input.is_action_pressed(key_right):
		direction = Vector2.RIGHT
		step()
	
	if Input.is_action_just_pressed(key_burst): # brez "just" dela po stisku smeri ... ni ok
		current_state = States.COCKING
		glow_light_on()
		

func cocking_inputs():
	
	# cocking
	if Input.is_action_pressed(key_up):
		if not burst_direction_set:
			direction = Vector2.DOWN
			burst_direction_set = true
		else:
			cock_burst()
	if Input.is_action_pressed(key_down):
		if not burst_direction_set:
			direction = Vector2.UP
			burst_direction_set = true
		else:
			cock_burst()
	if Input.is_action_pressed(key_left):
		if not burst_direction_set:
			direction = Vector2.RIGHT
			burst_direction_set = true
		else:
			cock_burst()
	if Input.is_action_pressed(key_right):
		if not burst_direction_set:
			direction = Vector2.LEFT
			burst_direction_set = true
		else:
			cock_burst()
	
	# releasing		
	if Input.is_action_just_released(key_burst):
		if not burst_direction_set:
			end_move()
		else:
			release_burst()
			glow_light_off()
			

func bursting_inputs():
	
	if Input.is_action_just_pressed(key_burst):
		end_move()
		Input.start_joy_vibration(0, 0.6, 0.2, 0.2)
		Global.sound_manager.play_sfx("burst_stop")
		Global.sound_manager.stop_sfx("burst_cocking")	
		

func skill_inputs():
	
	if has_no_energy: # ne more skillat, če ni energije
		return
		
	var new_direction # nova smer, ker pritisnem še enkrat
	var collider: Object = Global.detect_collision_in_direction(vision_ray, direction)
	
	# s tem inputom prekinem "is_pressed" input
	if Input.is_action_just_pressed(key_up):
		new_direction = Vector2.UP
	elif Input.is_action_just_pressed(key_down):
		new_direction = Vector2.DOWN
	elif Input.is_action_just_pressed(key_left):
		new_direction = Vector2.LEFT
	elif Input.is_action_just_pressed(key_right):
		new_direction = Vector2.RIGHT
	
	# izhod iz skilled stanja
	if new_direction:
		var pressed_direction_angle: float = round(rad2deg(vision_ray.cast_to.angle_to(new_direction)))
		if abs(pressed_direction_angle) == 90 or (pressed_direction_angle == 180 and collider.is_in_group(Global.group_tilemap)):
			current_state = States.IDLE
			return	
		
	# prehod v cocking stanje
	if Input.is_action_just_pressed(key_burst): # brez "just" dela po stisku smeri ... ni ok
		current_state = States.COCKING
		skill_light_off()
		glow_light_on()
		return	
			
	# izbor skila
	var wall_tile_index = 3
	if new_direction == direction:
		if collider.is_in_group(Global.group_tilemap):
			var colliding_tile_id = collider.get_collision_tile_id(self, direction) # pošljem self, ker kolajder (tilemap) ima koordinate 0,0
			if colliding_tile_id == wall_tile_index:
				teleport()
		elif collider.is_in_group(Global.group_strays):
			push()	
	if new_direction == - direction:
		if collider.is_in_group(Global.group_strays):
			pull()	

	
# MOVEMENT ------------------------------------------------------------------------------------------


func step():
	
	if has_no_energy: # ne more stepat, če ni energije
		return
		
	var step_direction = direction
	
	# če kolajda izbrani smeri gibanja prenesem kontrole na skill
	if not Global.detect_collision_in_direction(vision_ray, step_direction):
		current_state = States.STEPPING
		global_position = Global.snap_to_nearest_grid(global_position)
		spawn_trail_ghost()
		var step_tween = get_tree().create_tween().set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_IN_OUT)	
		step_tween.tween_property(self, "position", global_position + direction * cell_size_x, step_time)
		step_tween.tween_callback(self, "end_move")
		Global.sound_manager.play_stepping_sfx(player_energy / max_player_energy) # ulomek je za pitch zvoka

		# pošljem signal, da odštejem točko
		emit_signal("stat_changed", self, "cells_traveled", 1)

		
func end_move():
	
	# reset burst
	burst_speed = 0 # more bit pred change state, če ne uničuje tudi sam sebe
	burst_speed_max = 0
	burst_direction_set = false
	cocking_room = true
	
	# ugasnem lučke
	if glow_light.enabled:
		glow_light_off()
	if skill_light.enabled:
		skill_light_off()
		
	direction = Vector2.ZERO # reset ray dir
	
	if is_virgin:
		lose_virginity() # barvo prevzame na koncu tweena
	else:
		modulate = pixel_color
	
	global_position = Global.snap_to_nearest_grid(global_position) 
	current_state = States.IDLE
	
	if Global.sound_manager.teleport_loop.is_playing(): # zazih ... export for windows 
		Global.sound_manager.stop_sfx("teleport")
	

# BURST ------------------------------------------------------------------------------------------


func cock_burst():

	var burst_direction = direction
	var cock_direction = - burst_direction
	
	# prostor za začetek napenjanja preverja pixel
	if Global.detect_collision_in_direction(vision_ray, cock_direction): 
		Global.sound_manager.stop_sfx("burst_cocking")
		end_move()
		return
	
	if is_virgin:
		lose_virginity()
		
	# prostor nadaljevanje napenjanja preverja ghost
	if cocked_ghosts.size() < cocked_ghost_count_max and cocking_room:
		# čas držanja tipke (znotraj nastajanja ene cock celice)
		ghost_cocking_time += 1 / 60.0 # fejk delta
		# ko poteče čas za eno celico mimo, jo spawnam
		if ghost_cocking_time > ghost_cocking_time_limit:
			ghost_cocking_time = 0
			# prištejem hitrost bursta
			burst_speed_max += burst_speed_addon
			# spawnaj cock celico
			spawn_cock_ghost(cock_direction, cocked_ghosts.size() + 1) # + 1 zato, da se prvi ne spawna direktno nad pixlom
			Global.sound_manager.play_sfx("burst_cocking")


func release_burst():
	
	if burst_speed_max == 0: # če je vmes zadet
		return
		
	current_state = States.RELEASING
	
	Global.sound_manager.play_sfx("burst_cocked")

	# napeti ghosti animirajo do alfa 1
	for ghost in cocked_ghosts:
		var get_set_tween = get_tree().create_tween()
		get_set_tween.tween_property(ghost, "modulate:a", 1, cocked_ghost_fill_time)
		yield(get_tree().create_timer(cocked_ghost_fill_time),"timeout")
	# pavza pred strelom	
	yield(get_tree().create_timer(cocked_pause_time), "timeout")
	burst(cocked_ghosts.size())
		

func burst(current_ghost_count):
	
	
	emit_signal("stat_changed", self, "burst_released", 1)		
	
	var burst_direction = direction
	burst_cocked_ghost_count = current_ghost_count
	var ray_collider = vision_ray.get_collider() # ! more bit za detect_wall() ... ta ga šele pogreba?
	var backup_direction = - burst_direction

	# spawn stretch ghost
	var new_stretch_ghost = spawn_ghost(global_position)
	
	# vertikalno ali horizontalno?
	if burst_direction.y == 0: # če je smer horiz
		new_stretch_ghost.scale = Vector2(current_ghost_count, 1)
	elif burst_direction.x == 0: # če je smer ver
		new_stretch_ghost.scale = Vector2(1, current_ghost_count)
	
	# strech ghost 
	new_stretch_ghost.position = global_position - (burst_direction * cell_size_x * current_ghost_count)/2 - burst_direction * cell_size_x/2
	
	# sprazni ghoste
	for ghost in cocked_ghosts:
		ghost.queue_free()
	cocked_ghosts = []
	
	Global.sound_manager.play_sfx("burst")
	Global.sound_manager.stop_sfx("burst_cocking")
	
	# release ghost 
	current_state = States.BURSTING
	
	var release_tween = get_tree().create_tween()
	release_tween.tween_property(new_stretch_ghost, "scale", Vector2.ONE, strech_ghost_shrink_time).set_trans(Tween.TRANS_QUINT).set_ease(Tween.EASE_IN)
	release_tween.parallel().tween_property(new_stretch_ghost, "position", global_position - burst_direction * cell_size_x, strech_ghost_shrink_time).set_trans(Tween.TRANS_QUINT).set_ease(Tween.EASE_IN)
	# release pixel
	release_tween.tween_callback(new_stretch_ghost, "queue_free")
	release_tween.parallel().tween_property(self, "burst_speed", burst_speed_max, 0).set_trans(Tween.TRANS_QUINT).set_ease(Tween.EASE_IN)
	
	# zaključek .. tudi signal za pobiranje barv ... v on_collision()

	
# SKILLS ------------------------------------------------------------------------------------------

		
func push():
	
			
	var push_direction = direction
	var backup_direction = - push_direction
	var ray_collider = vision_ray.get_collider() # ! more bit za detect_wall() ... ta ga šele pogreba?
	
	# prostor za zalet?
	if Global.detect_collision_in_direction(vision_ray, backup_direction):
		return
	
	current_state = States.SKILLING
	
	# spawn ghosta pod pixlom
	var new_push_ghost_position = global_position + push_direction * cell_size_x
	var new_push_ghost = spawn_ghost(new_push_ghost_position)
	
	if ray_collider.is_in_group(Global.group_strays):
		# ni prostora
		if Global.detect_collision_in_direction(ray_collider.vision_ray, push_direction):
			Global.sound_manager.play_sfx("push")
			var empty_push_tween = get_tree().create_tween()
			empty_push_tween.tween_property(self, "position", global_position + backup_direction * cell_size_x * push_cell_count, push_time).set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_OUT)	
			empty_push_tween.parallel().tween_property(skill_light, "position", skill_light.position - backup_direction * cell_size_x * push_cell_count, push_time).set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_OUT)	
			empty_push_tween.parallel().tween_property(new_push_ghost, "position", new_push_ghost.global_position + backup_direction * cell_size_x * push_cell_count, push_time).set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_OUT)	
			empty_push_tween.tween_property(self, "position", global_position, 0.2).set_trans(Tween.TRANS_EXPO).set_ease(Tween.EASE_IN)	
			empty_push_tween.parallel().tween_callback(self, "skill_light_off")
			empty_push_tween.tween_property(skill_light, "position", skill_light.position, 0) # reset pozicije luči # reset pozicije luči
			empty_push_tween.parallel().tween_callback(self, "end_move")
			empty_push_tween.parallel().tween_callback(new_push_ghost, "queue_free")
		# je prostor
		else: 
			Global.sound_manager.play_sfx("push")
			# napnem
			var push_tween = get_tree().create_tween()
			push_tween.tween_property(self, "position", global_position + backup_direction * cell_size_x * push_cell_count, push_time).set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_OUT)	
			push_tween.parallel().tween_property(skill_light, "position", skill_light.position - backup_direction * cell_size_x * push_cell_count, push_time).set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_OUT)	
			push_tween.parallel().tween_property(new_push_ghost, "position", new_push_ghost.global_position + backup_direction * cell_size_x * push_cell_count, push_time).set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_OUT)	
			# spustim
			push_tween.tween_property(self, "position", global_position, 0.2).set_trans(Tween.TRANS_EXPO).set_ease(Tween.EASE_IN)	
			push_tween.parallel().tween_callback(self, "skill_light_off")
			push_tween.parallel().tween_property(new_push_ghost, "position", new_push_ghost_position, 0.2).set_trans(Tween.TRANS_EXPO).set_ease(Tween.EASE_IN)	
			push_tween.tween_property(skill_light, "position", skill_light.position, 0) # reset pozicije luči
			push_tween.parallel().tween_callback(Global.sound_manager, "play_sfx", ["pushed"])
			push_tween.parallel().tween_callback(new_push_ghost, "queue_free")
			push_tween.tween_property(ray_collider, "position", ray_collider.global_position + push_direction * cell_size_x * push_cell_count, 0.08).set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_OUT).set_delay(0.05)
			push_tween.tween_callback(self, "end_move")
			push_tween.tween_callback(self, "emit_signal", ["stat_changed", self, "skill_used", 0]) # 0 = push, 1 = pull, 2 = teleport ... za prepoznavanje
			

func pull():
	
	var target_direction = direction
	var pull_direction = - target_direction
	var target_pixel = vision_ray.get_collider()
	
	# preverjam če ma prostor v smeri premika
	if Global.detect_collision_in_direction(vision_ray, pull_direction): 
		return	
	
	current_state = States.SKILLING
	
	# spawn ghosta pod mano
	var new_pull_ghost = spawn_ghost(global_position + target_direction * cell_size_x)
	
	Global.sound_manager.play_sfx("pull")
	var pull_tween = get_tree().create_tween().set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_IN_OUT)	
	pull_tween.tween_property(self, "position", global_position + pull_direction * cell_size_x * pull_cell_count, pull_time)
	pull_tween.parallel().tween_property(skill_light, "position", skill_light.position - pull_direction * cell_size_x * push_cell_count, push_time)
	pull_tween.parallel().tween_property(new_pull_ghost, "position", new_pull_ghost.global_position + pull_direction * cell_size_x * pull_cell_count, pull_time)
	pull_tween.tween_property(target_pixel, "position", target_pixel.global_position + pull_direction * cell_size_x * pull_cell_count, pull_time)
	pull_tween.parallel().tween_callback(self, "skill_light_off")
	pull_tween.parallel().tween_callback(Global.sound_manager, "play_sfx", ["pulled"])
	pull_tween.tween_property(skill_light, "position", skill_light.position, 0) # reset pozicije luči
	pull_tween.parallel().tween_callback(self, "end_move")
	pull_tween.parallel().tween_callback(new_pull_ghost, "queue_free")
	pull_tween.tween_callback(self, "emit_signal", ["stat_changed", self, "skill_used", 1]) # 0 = push, 1 = pull, 2 = teleport ... za prepoznavanje
	

func teleport():
		
	var teleport_direction = direction
	
	current_state = States.SKILLING
	
	Input.start_joy_vibration(0, 0.3, 0, 0)
	Global.sound_manager.play_sfx("teleport")
	
	# spawn ghost
	var new_teleport_ghost = spawn_ghost(global_position)
	new_teleport_ghost.direction = teleport_direction
	new_teleport_ghost.max_speed = ghost_max_speed
	new_teleport_ghost.modulate.a = modulate.a * 0.5
	new_teleport_ghost.z_index = 3
	new_teleport_ghost.connect("ghost_target_reached", self, "_on_ghost_target_reached")
	
	# kamera target
	if name == "p1":
		Global.p1_camera_target = new_teleport_ghost
	elif name == "p2":
		Global.p2_camera_target = new_teleport_ghost
	
#	skill_light_off()
	
	yield(get_tree().create_timer(0.2), "timeout")
	# zaključek v signalu _on_ghost_target_reached
	

# SPAWNING ------------------------------------------------------------------------------------------


func spawn_dizzy_particles():
	
	var new_dizzy_pixels = PixelDizzyParticles.instance()
	new_dizzy_pixels.global_position = global_position
	new_dizzy_pixels.modulate = pixel_color
	Global.node_creation_parent.add_child(new_dizzy_pixels)
	

func spawn_collision_particles():
	
	var new_collision_pixels = PixelCollisionParticles.instance()
	new_collision_pixels.global_position = global_position
	new_collision_pixels.modulate = pixel_color
	match direction:
		Vector2.UP: new_collision_pixels.rotate(deg2rad(-90))
		Vector2.DOWN: new_collision_pixels.rotate(deg2rad(90))
		Vector2.LEFT: new_collision_pixels.rotate(deg2rad(180))
		Vector2.RIGHT:new_collision_pixels.rotate(deg2rad(0))
	Global.node_creation_parent.add_child(new_collision_pixels)
	

func spawn_cock_ghost(cocking_direction, cocked_ghosts_count):
	
	# spawn ghosta pod manom
	var new_cock_ghost = spawn_ghost(global_position + cocking_direction * cell_size_x * cocked_ghosts_count)
	new_cock_ghost.global_position -= cocking_direction * cell_size_x/2
	new_cock_ghost.modulate.a  = cocked_ghost_alpha - (cocked_ghosts_count / cocked_ghost_alpha_divisor)
	new_cock_ghost.direction = cocking_direction
	
	# v kateri smeri je scale
	if direction.y == 0: # smer horiz
		new_cock_ghost.scale.x = 0
	elif direction.x == 0: # smer ver
		new_cock_ghost.scale.y = 0

	# animiram cell animacijo
	var cock_cell_tween = get_tree().create_tween()
	cock_cell_tween.tween_property(new_cock_ghost, "scale", Vector2.ONE, ghost_cocking_time_limit).set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_OUT)
	cock_cell_tween.parallel().tween_property(new_cock_ghost, "position", global_position + cocking_direction * cell_size_x * cocked_ghosts_count, ghost_cocking_time_limit).set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_OUT)
	
	# ray detect velikost je velikost napenjanja
	new_cock_ghost.ghost_ray.cast_to = direction * cell_size_x
	new_cock_ghost.connect("ghost_detected_body", self, "_on_ghost_detected_body")
	
	# dodam celico v array celic tega zaleta
	cocked_ghosts.append(new_cock_ghost)	

	
func spawn_trail_ghost():
	
	var trail_alpha: float = 0.2
	var trail_ghost_fade_time: float = 0.4
	var new_trail_ghost = spawn_ghost(global_position)
	new_trail_ghost.modulate = pixel_color
	new_trail_ghost.modulate.a = trail_alpha
	
	# fadeout
	var trail_fade_tween = get_tree().create_tween()
	trail_fade_tween.tween_property(new_trail_ghost, "modulate:a", 0, trail_ghost_fade_time).set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_OUT)
	trail_fade_tween.tween_callback(new_trail_ghost, "queue_free")
	
	
func spawn_ghost(current_pixel_position):
	
	var new_pixel_ghost = Ghost.instance()
	new_pixel_ghost.global_position = current_pixel_position
	new_pixel_ghost.modulate = pixel_color
	Global.node_creation_parent.add_child(new_pixel_ghost)

	return new_pixel_ghost
	

# UTIL ------------------------------------------------------------------------------------------


func on_get_hit(added_shake_power, added_shake_time):
	
	# efekti
	Input.start_joy_vibration(0, 0.5, 0.6, 0.7)
	player_camera.shake_camera(added_shake_power, added_shake_time, hit_stray_shake_decay)	
	spawn_dizzy_particles()

	# uničim morebitno napenjanje
	if burst_speed_max > 0: 
		burst_speed_max = 0
		for ghost in cocked_ghosts:
			var fade_out = get_tree().create_tween()
			fade_out.tween_property(ghost, "modulate:a", 0, 0.2)
			fade_out.tween_callback(ghost, "queue_free")
		cocked_ghosts = []
				
	# stats				
#	Global.game_manager.game_settings["player_start_color"] = Color("#545454") # temp
	pixel_color = Global.game_manager.game_settings["player_start_color"] # postane začetne barve
	emit_signal("stat_changed", self, "hit_by_player", 1)
	die()
	

func on_hit_stray(hit_stray: KinematicBody2D):
	
		if Global.game_manager.game_settings["pick_neighbor_mode"]:
			if Global.game_manager.colors_to_pick and not Global.game_manager.colors_to_pick.has(hit_stray.pixel_color): # če pobrana barva ni enaka barvi soseda
				end_move()
			else:
				pixel_color = hit_stray.pixel_color
				Global.hud.show_picked_color(hit_stray.pixel_color)
				hit_stray.die(0) # edini
				emit_signal("stat_changed", self, "hit_stray", [1, hit_stray])
		else:
			pixel_color = hit_stray.pixel_color
			Global.hud.show_picked_color(hit_stray.pixel_color)
			
			var stacked_neighbors = check_for_neighbors(hit_stray)
			if stacked_neighbors.empty(): # nima sosed
				hit_stray.die(0) # 0 pomeni, da je solo (drugačna animacija)
			else: # ma sosede
				destroy_all_stacked(stacked_neighbors, hit_stray)
			
			# statistika pobitih
			var destroyed_strays_count: int
			if burst_cocked_ghost_count == cocked_ghost_count_max: # moč je maximalna moč
				destroyed_strays_count = stacked_neighbors.size() + 1
			elif burst_cocked_ghost_count > stacked_neighbors.size() + 1: # moč je enaka količini stackanih straysov
				destroyed_strays_count = stacked_neighbors.size() + 1 # moč je enaka ali manjša, kot količini stackanih straysov
			else:
				destroyed_strays_count = burst_cocked_ghost_count
			
			emit_signal("stat_changed", self, "hit_stray", destroyed_strays_count)
				
				
func check_for_neighbors(hit_stray):

		var all_neighboring_strays: Array = [] # vsi nabrani sosedi
		var neighbors_checked: Array = [] # vsi sosedi, katerih sosede sem že preveril

		# prva runda ... sosede zadetega straya
		var first_neighbors: Array = hit_stray.check_for_neighbors()
		for first_neighbor in first_neighbors:
			if not all_neighboring_strays.has(first_neighbor): # če še ni dodan med vse sosede
				all_neighboring_strays.append(first_neighbor) # ... ga dodam med vse sosede
		neighbors_checked.append(hit_stray) # zadeti stray gre med "že preverjene" 
		
		# druga runda ... sosede vseh sosed
		for neighbor in all_neighboring_strays:
			if not neighbors_checked.has(neighbor): # če še ni med "že preverjenimi" ...
				var extra_neighbors: Array = neighbor.check_for_neighbors() # ... preverim še njegove sosede
				for extra_neighbor in extra_neighbors:
					if not all_neighboring_strays.has(extra_neighbor):  # če še ni dodan med vse sosede ...
						all_neighboring_strays.append(extra_neighbor) # ... ga dodam med vse sosede
				neighbors_checked.append(neighbor) # po nabirki ga dodam med preverjene sosede
		
		# hit stray izbrišem iz sosed, ker bo uničen posebej
		if all_neighboring_strays.has(hit_stray): 
			all_neighboring_strays.erase(hit_stray)
			
		return all_neighboring_strays


func destroy_all_stacked(all_neighboring_strays, hit_stray):
		
		# uničim zadetega
		hit_stray.die(1)
		# uničim preostale sosede
		var stray_in_row = 2 # za določanje koliko jih uniči določena moč in zaporedje ... hit stray je 1
		for neighboring_stray in all_neighboring_strays:
			if (stray_in_row - 1) < burst_cocked_ghost_count or burst_cocked_ghost_count == cocked_ghost_count_max: # odvisnost od moči bursta
				Global.hud.show_picked_color(neighboring_stray.pixel_color) # indikator efekt
				neighboring_stray.die(stray_in_row)
			stray_in_row += 1


func die():

	player_camera.shake_camera(die_shake_power, die_shake_time, die_shake_decay)
	set_physics_process(false)
	animation_player.play("die_player")


func revive():
	
	var dead_time: float = 2
	yield(get_tree().create_timer(dead_time), "timeout")
	animation_player.play("revive")


func play_blinking_sound(): 
	# kličem iz animacije
	
	Global.sound_manager.play_sfx("blinking")


func lose_virginity():
	
	if not has_no_energy:
		animation_player.stop()
	var color_fade_in = get_tree().create_tween()
	color_fade_in.tween_property(self, "modulate", pixel_color, 0.3).set_ease(Tween.EASE_OUT)
	color_fade_in.tween_property(self, "is_virgin", false, 0)


func glow_light_on():
	
	glow_light.color = pixel_color

	var glow_light_base_energy: float = 0.35

	if pixel_color.get_luminance() == 1: # bela
		glow_light_base_energy = 0.55
	elif pixel_color.get_luminance() > 0.90:
		glow_light_base_energy += 0.2
	elif pixel_color.get_luminance() > 0.75:
		glow_light_base_energy += 0.15
	elif pixel_color.get_luminance() > 0.50:
		glow_light_base_energy += 0.05
	
	var glow_light_energy: float = glow_light_base_energy / pixel_color.get_luminance()

	var light_fade_in = get_tree().create_tween()
	light_fade_in.tween_callback(glow_light, "set_enabled", [true])
	light_fade_in.tween_property(glow_light, "energy", glow_light_energy, 0.2).set_ease(Tween.EASE_IN)


func glow_light_off():
	
	var light_fade_out = get_tree().create_tween()
	light_fade_out.tween_property(glow_light, "energy", 0, 0.2).set_ease(Tween.EASE_IN)
	light_fade_out.tween_callback(glow_light, "set_enabled", [false])


func skill_light_on():
	
	skill_light.rotation = vision_ray.cast_to.angle()
	skill_light.color = pixel_color
	
	var skilled_light_base_energy: float = 0.55
	if pixel_color.get_luminance() == 1: # bela
		skilled_light_base_energy = 0.65
	elif pixel_color.get_luminance() < 0.1: # temno siva
		skilled_light_base_energy = 0.3
	var skilled_light_energy: float = skilled_light_base_energy / pixel_color.get_luminance()
		
	var light_fade_in = get_tree().create_tween()
	light_fade_in.tween_callback(skill_light, "set_enabled", [true])
	light_fade_in.tween_property(skill_light, "energy", skilled_light_energy, 0.2).set_ease(Tween.EASE_IN)
	
	
func skill_light_off():
	
	var light_fade_out = get_tree().create_tween()
	light_fade_out.tween_property(skill_light, "energy", 0, 0.2).set_ease(Tween.EASE_IN)
	light_fade_out.tween_callback(skill_light, "set_enabled", [false])


# SIGNALI ------------------------------------------------------------------------------------------
	
		
func _on_ghost_target_reached(ghost_body, ghost_position):
	
	var player_camera_target: String
	if name == "p1":
		player_camera_target = "p1_camera_target"
	elif name == "p2":
		player_camera_target = "p2_camera_target"
	
	Global.sound_manager.stop_sfx("teleport")
	Input.stop_joy_vibration(0)
			
	var ghost_fade_time: float = 0.5
	
	var teleport_tween = get_tree().create_tween()
	teleport_tween.tween_property(self, "modulate:a", 0, ghost_fade_time * 2/3).set_ease(Tween.EASE_IN)
	teleport_tween.parallel().tween_callback(self, "skill_light_off")
	teleport_tween.parallel().tween_property(ghost_body, "modulate:a", 1, ghost_fade_time).set_ease(Tween.EASE_IN)
	teleport_tween.tween_property(self, "global_position", ghost_position, 0)
	teleport_tween.parallel().tween_callback(self, "end_move")
	teleport_tween.parallel().tween_property(self, "modulate:a", 1, 0)
	teleport_tween.parallel().tween_callback(ghost_body, "queue_free")
	teleport_tween.parallel().tween_property(Global, player_camera_target, self, 0) # camera follow reset
	teleport_tween.tween_callback(self, "emit_signal", ["stat_changed", self, "skill_used", 2]) # 0 = push, 1 = pull, 2 = teleport ... za prepoznavanje


func _on_ghost_detected_body(body):
	
	if body != self:
		cocking_room = false
		Global.sound_manager.play_sfx("burst_limit")
		

func _on_AnimationPlayer_animation_finished(anim_name: String) -> void:
	
	match anim_name:
		"heartbeat":
			heartbeat_loop += 1
			if heartbeat_loop <= 5 and heartbeat_active:
				animation_player.play("heartbeat")
				Global.sound_manager.play_sfx("heartbeat")
			elif heartbeat_active:
				glow_light.enabled = false
				emit_signal("stat_changed", self, "out_of_energy", 1)
				die()
		"revive":
			set_physics_process(true)
		"virgin_blink":
			if is_virgin and not heartbeat_active:
				animation_player.play("virgin_blink")
