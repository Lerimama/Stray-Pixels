class_name Pixel
extends KinematicBody2D


signal stat_changed (stat_owner, stat, stat_change)

# states
enum States {
	WHITE = 1, # steping
	BLUE, # burst 
	GREEN, # bump 
	RED, 
	YELLOW,
} 
var state_colors: Dictionary = {
	1: Config.color_white, 
	2: Config.color_blue, 
	3: Config.color_green, 
	4: Config.color_red, 
	5: Config.color_yellow,
}	
var skill_activated: bool = false
var current_state : int = States.WHITE setget _change_state # tole je int ker je rezultat številka
var pixel_color = state_colors[current_state]

# testing modes
export var slide_mode: bool = false # slajdanje če držiš smerno tipko

# arena
var cell_size_x: int # pogreba od arene, ki jo dobi od tilemapa
var floor_cells: Array = []

# steping
export(int, 1, 10) var steping_frame_skip: int = 10 # za kontrolo hitrosti
export(int, 1, 10)  var death_mode_frame_skip = 2
var frame_counter: int # pseudo time 
var step_time: float = 0.15 # tween time
var step_cell_count: int = 1 # je naslednja

# motiion
var speed: float = 0
#var max_speed: float = 10 # ker je na vseh pixlih, ampak tu ne rabim
#var accelaration: float = 500 # ne rabim ... ampak je na vseh pixlih
var velocity: Vector2
var direction = Vector2.ZERO
var collision: KinematicCollision2D
	
# skills
var skill_change_count: int = 0
var ghost_fade_time = 0.2
var pull_time: float = 0.6
var pull_cell_count: int = 1
var push_time: float = 0.5
var push_cell_count: int = 1
var cockup_cells_count = 0
var backup_time = 0.32
var cockup_cell_time = 15
var burst_speed = 0
var burst_time = 0.1
var burst_ghost_fade_time = 1.7 * burst_time
var cockup_time = 0
var cocking_cells: Array
var cocking_room: bool = true

var new_tween: SceneTreeTween

onready var poly_pixel: Polygon2D = $PolyPixel
onready var collision_ray: RayCast2D = $RayCast2D
onready var animation_player: AnimationPlayer = $AnimationPlayer
onready var collision_shape: CollisionShape2D = $CollisionShape2D
onready var detect_area: Area2D = $DetectArea

onready var PixelGhost = preload("res://scenes/PixelGhost.tscn")
onready var PixelExplosion = preload("res://scenes/PixelExplosion.tscn")


func _ready() -> void:
	
	Global.print_id(self)
	add_to_group(Config.group_players)
	
	# snap it
	cell_size_x = 32 #Global.game_manager.grid_cell_size.x # get cell size ... če je tole noče delat sama
	global_position = global_position.snapped(Vector2.ONE * cell_size_x)
	global_position += Vector2.ONE * cell_size_x/2 # zamik centra


func _physics_process(delta: float) -> void:
	
	if Input.is_action_just_pressed("x"):
		explode_pixel()
	
	state_machine()
#	modulate = state_colors[current_state] ... težko vplivam če je tukaj
#	print("current color", state_colors[current_state], pixel_color)
	
	frame_counter += 1
	
	# dokler je speed 0, je velocity tudi 0 v tweenih speed se regulira v tweenu
	velocity = direction * speed # 
	move_and_collide(velocity) 
		
	if collision:
#		velocity = velocity.bounce(collision.normal)
		print("KOLIZIJA")
	

func state_machine():
	
	# ne manjaj stanj sredi akcije
	if skill_activated:
		return
		
	match current_state: 
		States.WHITE:
			step_control()
		States.BLUE:
			push_control()
		States.GREEN: 
			pull_control()
		States.RED:
			burst_control()
		States.YELLOW:
			teleport_control()
	
	# change state
	if Input.is_action_just_pressed("shift"):
		select_next_state()	
		
		
func select_next_state():
		
		# ciklanje v zaporedju
		if current_state < States.size():
			self.current_state = current_state + 1 
		else:		
			self.current_state = 1	


func _change_state(new_state_id):
	
	# set normal mode
	skill_activated = false
	direction = Vector2.ZERO
	collision_ray.cast_to = direction * cell_size_x # ray kaže na naslednjo pozicijo 
	collision_ray.force_raycast_update()	
	snap_to_nearest_grid()

	# transition
	
	# statistika
	skill_change_count += 1
	emit_signal("stat_changed", self, "skill_change_count", 1)
	
	# new state
	current_state = new_state_id
	modulate = state_colors[current_state]


func step_control():
	
	if Input.is_action_pressed("ui_up"):
		direction = Vector2.UP
		step_by_step(direction)
	elif Input.is_action_pressed("ui_down"):
		direction = Vector2.DOWN
		step_by_step(direction)
	elif Input.is_action_pressed("ui_left"):
		direction = Vector2.LEFT
		step_by_step(direction)
	elif Input.is_action_pressed("ui_right"):
		direction = Vector2.RIGHT
		step_by_step(direction)
	else:
#		if not dir_memory_mode:
		direction = Vector2.ZERO
		# reset ray
		collision_ray.cast_to = direction * cell_size_x 
	
	
		
func step_by_step(direction): 
	# premik samo, če je smerna tipka stisnjena
		
	# če vidi steno v planirani smeri
	if detect_collision_in_direction(direction) or skill_activated: 
		return	
	
	if Global.game_manager.deathmode_on:
		steping_frame_skip = death_mode_frame_skip
		
	if frame_counter % steping_frame_skip == 0:
		global_position += direction * cell_size_x # premik za velikost celice


# SKILLS SEKCIJA ______________________________________________________________________________________________________________


func burst_control():

	if Input.is_action_pressed("ui_up"):
		direction = Vector2.DOWN
		var cockup_direction = - direction
		if cocking_room:
			cockup_time += 1
			if cockup_time > cockup_cell_time:
				cockup_time = 0 
				cockup_cells_count += 1
				burst_speed += 5
				spawn_cockup_cell(cockup_direction, cockup_cells_count)
			if cockup_cells_count > 7:
				release_cockup_cells()
				burst(direction, cockup_cells_count)
	
	if Input.is_action_just_released("ui_up"):
		direction = Vector2.DOWN
		cockup_time = 0
		release_cockup_cells()
		burst(direction, cockup_cells_count)
	
	if Input.is_action_pressed("ui_down"):
		direction = Vector2.UP
		var cockup_direction = - direction
		if cocking_room:
			cockup_time += 1
			if cockup_time > cockup_cell_time:
				cockup_time = 0 
				cockup_cells_count += 1
				burst_speed += 5
				spawn_cockup_cell(cockup_direction, cockup_cells_count)
			if cockup_cells_count > 7:
				release_cockup_cells()
				burst(direction, cockup_cells_count)
	
	if Input.is_action_just_released("ui_down"):
		
		direction = Vector2.UP
		cockup_time = 0
		release_cockup_cells()
		burst(direction, cockup_cells_count)
	
	if Input.is_action_pressed("ui_left"):
		direction = Vector2.RIGHT
		var cockup_direction = - direction
		if cocking_room:
			cockup_time += 1
			if cockup_time > cockup_cell_time:
				cockup_time = 0 
				cockup_cells_count += 1
				burst_speed += 5
				spawn_cockup_cell(cockup_direction, cockup_cells_count)
			if cockup_cells_count > 7:
				release_cockup_cells()
				burst(direction, cockup_cells_count)
				
	if Input.is_action_just_released("ui_left"):
		direction = Vector2.RIGHT
		cockup_time = 0
		release_cockup_cells()
		burst(direction, cockup_cells_count)
		
	if Input.is_action_pressed("ui_right"):
		
		direction = Vector2.LEFT
		var cockup_direction = - direction
		if cocking_room:
			cockup_time += 1
			if cockup_time > cockup_cell_time:
				cockup_time = 0 
				cockup_cells_count += 1
				burst_speed += 5
				spawn_cockup_cell(cockup_direction, cockup_cells_count)
			if cockup_cells_count > 7:
				release_cockup_cells()
				burst(direction, cockup_cells_count)
				
	if Input.is_action_just_released("ui_right"):
		
		direction = Vector2.LEFT
		cockup_time = 0
		release_cockup_cells()
		burst(direction, cockup_cells_count)


func spawn_cockup_cell(direction, cell_count):
	
	# spawn ghost pod mano
	var new_pixel_ghost = PixelGhost.instance()
	new_pixel_ghost.global_position = global_position + direction * cell_size_x * cell_count
	new_pixel_ghost.modulate = state_colors[current_state]
	new_pixel_ghost.modulate.a = 0.3
	Global.node_creation_parent.add_child(new_pixel_ghost)
	
	
	new_pixel_ghost.ghost_ray.cast_to = direction * cell_size_x
	new_pixel_ghost.connect("ghost_detected_body", self, "_on_ghost_detected_body")
	
	cocking_cells.append(new_pixel_ghost)
	
	
func release_cockup_cells():

	for cocking_cell in cocking_cells:
		cocking_cell.fade_out()
		yield(get_tree().create_timer(0.05),"timeout")
	cocking_cells = []
	cockup_time = 0
	cockup_cells_count = 0
	
	
func burst(burst_direction, backup_cells_count):

	# se ne dotika ničesar v smeri?	
	if skill_activated:
		return	
		
	detect_collision_in_direction(burst_direction*backup_cells_count)
		
	var ray_collider = collision_ray.get_collider() # ! more bit za detect_wall() ... ta ga šele pogreba?
	var backup_direction = - burst_direction

	skill_activated = true

	# spawn ghost pod mano
	var new_pixel_ghost = PixelGhost.instance()
	new_pixel_ghost.global_position = global_position
	new_pixel_ghost.modulate = state_colors[current_state]
	Global.node_creation_parent.add_child(new_pixel_ghost)
	
	# set strech direction
	var ghost_scale: Vector2 # zunaj zato da jo lahko twinamo
	if burst_direction.y == 0: # če je smer horiz
		ghost_scale = Vector2(backup_cells_count, 1)
	elif burst_direction.x == 0: # če je smer ver
		ghost_scale = Vector2(1 ,backup_cells_count)
	
	new_tween = get_tree().create_tween()
	# napnem
	new_tween.tween_property(self, "position", global_position + backup_direction * cell_size_x * backup_cells_count, backup_time).set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_OUT)
	# raztegnem ghosta
	new_tween.parallel().tween_property(new_pixel_ghost, "position", new_pixel_ghost.global_position + (backup_direction * cell_size_x * backup_cells_count)/2, backup_time).set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_OUT)
	new_tween.parallel().tween_property(new_pixel_ghost, "scale", ghost_scale, backup_time).set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_OUT)
	# spustim
	new_tween.tween_property(self, "speed", burst_speed, burst_time).set_trans(Tween.TRANS_QUINT).set_ease(Tween.EASE_IN)
	new_tween.parallel().tween_property(new_pixel_ghost, "position", new_pixel_ghost.global_position, burst_ghost_fade_time).set_trans(Tween.TRANS_QUINT).set_ease(Tween.EASE_IN)
	new_tween.parallel().tween_property(new_pixel_ghost, "scale:x", 1, burst_ghost_fade_time).set_trans(Tween.TRANS_QUINT).set_ease(Tween.EASE_IN)
	new_tween.parallel().tween_callback(new_pixel_ghost, "queue_free").set_delay(burst_ghost_fade_time)
	
	# zaključek v signalu _on_DetectArea_body_entered
	
	
func push_control():
	
	if Input.is_action_just_pressed("ui_up"):
		direction = Vector2.UP
		push(direction)
	elif Input.is_action_just_pressed("ui_down"):
		direction = Vector2.DOWN
		push(direction)
	elif Input.is_action_just_pressed("ui_left"):
		direction = Vector2.LEFT
		push(direction)
	elif Input.is_action_just_pressed("ui_right"):
		direction = Vector2.RIGHT
		push(direction)
	

func push(push_direction):
	
	# se dotika nečesa v smeri?	
	if not detect_collision_in_direction(push_direction) or skill_activated: # preverjam obstoj kolizijo s pixlom ... if collision_ray.is_colliding(): .. ne rabim
		return
		
	var ray_collider = collision_ray.get_collider() # ! more bit za detect_wall() ... ta ga šele pogreba?
	var backup_direction = - push_direction
	
	# se dotika pixla v smeri?
	if not ray_collider.is_in_group(Config.group_strays):
		return	
	# ima prostor za zalet?
	if detect_collision_in_direction(backup_direction):
		return	
	
	skill_activated = true
		
	# spawn ghost pod mano
	var new_pixel_ghost = PixelGhost.instance()
	new_pixel_ghost.global_position = global_position
	new_pixel_ghost.modulate = state_colors[current_state]
	Global.node_creation_parent.add_child(new_pixel_ghost)


	new_tween = get_tree().create_tween()
	# napnem
	new_tween.tween_property(self, "position", global_position + backup_direction * cell_size_x * push_cell_count, push_time).set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_OUT)	
	# spustim
	new_tween.tween_property(self, "position", global_position, 0.2).set_trans(Tween.TRANS_EXPO).set_ease(Tween.EASE_IN)	
	new_tween.tween_property(ray_collider, "position", ray_collider.global_position + push_direction * cell_size_x * push_cell_count, 0.1).set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_OUT)
	new_tween.tween_callback(self, "_change_state", [States.WHITE])
	new_tween.parallel().tween_callback(new_pixel_ghost, "queue_free")
	
	
func pull_control():
	
	if Input.is_action_just_pressed("ui_up"):
		direction = Vector2.DOWN
		pull(direction)
	elif Input.is_action_just_pressed("ui_down"):
		direction = Vector2.UP
		pull(direction)
	elif Input.is_action_just_pressed("ui_left"):
		direction = Vector2.RIGHT
		pull(direction)
	elif Input.is_action_just_pressed("ui_right"):
		direction = Vector2.LEFT
		pull(direction)
	

func pull(target_direction):
	# ray je usmerjen v smer 
	# če je tam tarča, spelje step()
	# če je prostor (preverja c stepu) se premakne stran od tarče
	# tarčina pozicija sledi pixlu
	# če je s se premakne v smer stran od nje
	
	if not detect_collision_in_direction(target_direction) or skill_activated: # preverjam obstoj kolizijo s pixlom ... if collision_ray.is_colliding(): .. ne rabim
		return	
	skill_activated = true

	var pull_direction = - target_direction
	var ray_collider = collision_ray.get_collider()
	
	if not ray_collider.is_in_group(Config.group_strays):
		return
	
	# spawn ghost pod mano
	var new_pixel_ghost = PixelGhost.instance()
	new_pixel_ghost.global_position = global_position
	new_pixel_ghost.modulate = state_colors[current_state]
	Global.node_creation_parent.add_child(new_pixel_ghost)
	
	new_tween = get_tree().create_tween().set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_IN_OUT)	
	new_tween.tween_property(self, "position", global_position + pull_direction * cell_size_x * pull_cell_count, pull_time)
	new_tween.tween_property(ray_collider, "position", ray_collider.global_position + pull_direction * cell_size_x * pull_cell_count, pull_time)
	new_tween.parallel().tween_property(new_pixel_ghost, "position", new_pixel_ghost.global_position + pull_direction * cell_size_x * pull_cell_count, pull_time)
	new_tween.tween_callback(self, "_change_state", [States.WHITE])
	new_tween.tween_callback(ray_collider, "select_next_state")
	new_tween.parallel().tween_callback(new_pixel_ghost, "queue_free")


func teleport_control():
	
	if Input.is_action_just_pressed("ui_up"):
		direction = Vector2.UP
		teleport(direction)
	elif Input.is_action_just_pressed("ui_down"):
		direction = Vector2.DOWN
		teleport(direction)
	elif Input.is_action_just_pressed("ui_left"):
		direction = Vector2.LEFT
		teleport(direction)
	elif Input.is_action_just_pressed("ui_right"):
		direction = Vector2.RIGHT
		teleport(direction)


func teleport(teleport_direction):
	
	# preverim če kolajda s steno
	if not detect_collision_in_direction(teleport_direction) or skill_activated:
		return	
	if collision_ray.get_collider().is_in_group(Config.group_strays):
		return
	skill_activated = true
	
	# spawn ghost
	var new_pixel_ghost = PixelGhost.instance()
	new_pixel_ghost.global_position = global_position
	new_pixel_ghost.direction = teleport_direction
	new_pixel_ghost.modulate = state_colors[current_state]
	new_pixel_ghost.floor_cells = floor_cells
	new_pixel_ghost.cell_size_x = cell_size_x
	Global.node_creation_parent.add_child(new_pixel_ghost)
	new_pixel_ghost.connect("ghost_target_reached", self, "_on_ghost_target_reached")
	
	# zaključek v signalu _on_ghost_target_reached
	
	
onready var poly_broken: Polygon2D = $PolyBroken
var pixel_break_time: float = 0.3

	
func explode_pixel():

	# breaking
	poly_broken.visible = true
#	poly_broken.modulate = state_colors[current_state]
	new_tween = get_tree().create_tween().set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
	new_tween.tween_property(poly_pixel, "position", Vector2.ZERO, pixel_break_time)
	new_tween.parallel().tween_property(poly_pixel, "scale", Vector2.ZERO, pixel_break_time)
	yield(get_tree().create_timer(pixel_break_time),"timeout")
	yield(get_tree().create_timer(0.1),"timeout")

	# spawn delaunay and explode
	var new_exploding_pixel = PixelExplosion.instance()
	new_exploding_pixel.modulate = state_colors[current_state]
	new_exploding_pixel.global_position = global_position - Vector2.ONE * cell_size_x / 2
	Global.node_creation_parent.add_child(new_exploding_pixel)

	poly_pixel.visible = false
	poly_broken.visible = false

	die()


func die():
	emit_signal("stat_changed", self, "player_life", -1)
	print("KVEFRI")
	queue_free()


# UTILITI SEKCIJA ______________________________________________________________________________________________________________


func detect_collision_in_direction(next_direction):
	
	collision_ray.cast_to = next_direction * cell_size_x # ray kaže na naslednjo pozicijo 
	collision_ray.force_raycast_update()	
	
	if collision_ray.is_colliding():
		return true


func snap_to_nearest_grid():
	
	floor_cells = Global.game_manager.available_positions
	var current_position = Vector2(global_position.x - cell_size_x/2, global_position.y - cell_size_x/2)
	
	# če ni že snepano
	if not floor_cells.has(current_position): 
		var distance_to_position: float = cell_size_x # začetna distanca je velikosti celice, ker na koncu je itak bližja
		var nearest_cell: Vector2
		for cell in floor_cells:
			if cell.distance_to(current_position) < distance_to_position:
				distance_to_position = cell.distance_to(current_position)
				nearest_cell = cell
		# snap it
		global_position = Vector2(nearest_cell.x + cell_size_x/2, nearest_cell.y + cell_size_x/2)
	

# SIGNALI ______________________________________________________________________________________________________________

		
func _on_ghost_target_reached(ghost_body, ghost_position):
	
	new_tween = get_tree().create_tween()
	new_tween.tween_property(self, "modulate:a", 0, ghost_fade_time)
	new_tween.tween_property(self, "global_position", ghost_position, 0.1)
	new_tween.tween_callback(self, "_change_state", [States.WHITE])
	new_tween.parallel().tween_callback(ghost_body, "fade_out")
#	new_tween.tween_property(self, "skill_activated", false, 0.01)
	pass
		
func _on_ghost_detected_body(body):
	
	if body != self:
		cocking_room = false
	


var pixel_color_sum: Color # suma barv za picla

# stats v hudu
onready var picked_color_rect: ColorRect = $"../UI/HUD/HudControl/PickedColor/ColorBox/ColorRect"
onready var color_value: Label = $"../UI/HUD/HudControl/PickedColor/Value"

var pixel_color_sum_r: float
var pixel_color_sum_g: float
var pixel_color_sum_b: float

func _on_DetectArea_body_entered(body: Node) -> void:
	
	if skill_activated:
		speed = 0
		if body.is_in_group(Config.group_strays):
			
			# poberi trenutni seštevek barv
			var current_color_sum = state_colors[current_state]
			
			# change pixel
			speed = 0
			_change_state(States.WHITE)
			
			
			# poberi barvo pixla
			var picked_color = body.modulate
			picked_color_rect.color = picked_color
			
			# picked color
			var rgb_red: float = picked_color.r * 255
			var rgb_green: float = picked_color.g * 255
			var rgb_blue: float = picked_color.b * 255
			var display_red: String = "%03d" % rgb_red
			var display_green: String = " %03d" % rgb_green
			var display_blue: String = " %03d" % rgb_blue
			
			# v hud
			color_value.text = display_red + display_green + display_blue
			
			# skupna barva
			pixel_color_sum = current_color_sum + picked_color # statistika jo pobere
						
			# za hud
			var pixel_color_sum_values = Color(pixel_color_sum)
			pixel_color_sum_r = round(pixel_color_sum_values.r * 255)
			pixel_color_sum_g = round(pixel_color_sum_values.g * 255)
			pixel_color_sum_b = round(pixel_color_sum_values.b * 255)
			Global.game_manager.player_color_sum_r = pixel_color_sum_r
			Global.game_manager.player_color_sum_g = pixel_color_sum_g
			Global.game_manager.player_color_sum_b = pixel_color_sum_b
			print("pixel_color_sum_values", pixel_color_sum_values, pixel_color_sum_r, pixel_color_sum_g, pixel_color_sum_b)
			
			# player color
			modulate = pixel_color_sum
		
			# stray disabled
			body.current_state = body.States.BLACK
			body.turn_off() # stray javi svojo smrt v hud
			
			
			printt("prev color sum", current_color_sum)
			printt("picked color", body.state_colors[body.current_state])
			printt("new color sum", pixel_color_sum)
			# seštej in zabeleži v statistiko
			
		else:	
			explode_pixel()


# OLD STEP

	
#func step_inputs():
#
#	if Input.is_action_just_pressed("ui_up"):
#		direction = Vector2.UP
#		step(direction)
#	elif Input.is_action_just_pressed("ui_down"):
#		direction = Vector2.DOWN
#		step(direction)
#	elif Input.is_action_just_pressed("ui_left"):
#		direction = Vector2.LEFT
#		step(direction)
#	elif Input.is_action_just_pressed("ui_right"):
#		direction = Vector2.RIGHT
#		step(direction)
#	else:
#		if not dir_memory_mode:
#			direction = Vector2.ZERO
#			# reset ray
#			collision_ray.cast_to = direction * cell_size_x 
#
#	if Input.is_action_pressed("space"):
#		run()

#
#func slide_inputs():
#
#	if Input.is_action_pressed("ui_up"):
#		direction = Vector2.UP
#		step(direction)
#	elif Input.is_action_pressed("ui_down"):
#		direction = Vector2.DOWN
#		step(direction)
#	elif Input.is_action_pressed("ui_left"):
#		direction = Vector2.LEFT
#		step(direction)
#	elif Input.is_action_pressed("ui_right"):
#		direction = Vector2.RIGHT
#		step(direction)
#	else:
#		if not dir_memory_mode:
#			direction = Vector2.ZERO
#			# reset ray
#			collision_ray.cast_to = direction * cell_size_x 
#
#	if Input.is_action_pressed("space"):
#		run()
#	if Input.is_action_just_released("space"):
#		snap_to_nearest_grid()


#func step(step_direction): 
#
#	# če vidi steno v planirani smeri
#	if detect_collision_in_direction(step_direction): # or skill_activated: ... nepotrebno, ker akcija se ne kliče avtmatično, če ni bela
#		return	
#
#	new_tween = get_tree().create_tween()
#	new_tween.tween_property(self, "position", global_position + step_direction * cell_size_x * step_cell_count, step_time).set_trans(Tween.TRANS_LINEAR).set_ease(Tween.EASE_IN_OUT)	
#
#	# pošljem signal, da odštejem točko
#	emit_signal("stat_changed", self, "cells_travelled", 1)
	