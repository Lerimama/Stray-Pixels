extends KinematicBody2D
class_name Stray_orig

enum States {IDLE, MOVING, DYING, WALL} # STATIC # static, unmovable ... ko je GO ali pa je poden
var current_state = States.IDLE # ni vready, da lahko setam že ob spawnu

var stray_color: Color
var step_attempt: int = 1 # če nima prostora, proba v drugo smer (največ 4krat)
var visible_on_screen: bool = false

onready var collision_shape: CollisionShape2D = $CollisionShape2D
onready var collision_shape_ext: CollisionShape2D = $CollisionShapeExt
onready var vision_rays: Array = [$Vision/VisionRay1, $Vision/VisionRay2, $Vision/VisionRay3]
onready var vision: Node2D = $Vision
onready var color_poly: Polygon2D = $ColorPoly
onready var animation_player: AnimationPlayer = $AnimationPlayer
onready var position_indicator: Node2D = $PositionIndicator
onready var position_indicator_poly: Polygon2D = $PositionIndicator/PositionPoly
onready var visibility_notifier_2d: VisibilityNotifier2D = $VisibilityNotifier2D
onready var cell_size_x: int = Global.current_tilemap.cell_size.x

# debug
onready var count_label: Label = $CountLabel 


func _ready() -> void:
	
	add_to_group(Global.group_strays)
	randomize() # za random die animacije
	
	color_poly.modulate = stray_color
	modulate.a = 0
	count_label.text = name
	position_indicator_poly.color = stray_color
	position_indicator.set_as_toplevel(true) # strayse skrijem ko so offscreen
	position_indicator.visible = false

	end_move()


func _process(delta: float) -> void:
	
	if Global.game_manager.show_position_indicators:
		if not position_indicator.visible:
			fade_position_indicator(true)
	else:
		if position_indicator.visible:
			fade_position_indicator(false)
	
	if position_indicator.visible:
		get_position_indicator_position(get_viewport().get_node("PlayerCamera"))
	
	
func show_stray(): # kliče GM
	
	$OverspawnDetect.monitoring = false
	$OverspawnDetect.monitorable = false
	
	# če je pozicija res prazna						
	if current_state == States.WALL:
		die_to_wall()
	else:
		# žrebam animacijo
		var random_animation_index = randi() % 3 + 1
		var random_animation_name: String = "glitch_%s" % random_animation_index
		animation_player.play(random_animation_name)
	
	
func die(stray_in_stack_index: int, strays_in_stack_count: int):
	
	if current_state == States.DYING:
		return
	current_state = States.DYING
	
	global_position = Global.snap_to_nearest_grid(self) 
	
	# čakalni čas
	var wait_to_destroy_time: float = sqrt(0.07 * (stray_in_stack_index)) # -1 je, da hitan stray ne čaka
	yield(get_tree().create_timer(wait_to_destroy_time), "timeout")
	
	# animacije
	if strays_in_stack_count <= 3: # žrebam
		var random_animation_index = randi() % 5 + 1
		var random_animation_name: String = "die_stray_%s" % random_animation_index
		animation_player.play(random_animation_name) 
	else: # ne žrebam
		animation_player.play("die_stray")

	position_indicator.modulate.a = 0	
	collision_shape.set_deferred("disabled", true)
	collision_shape_ext.set_deferred("disabled", true)
	
	# color vanish
	var vanish_time = animation_player.get_current_animation_length()
	var vanish_tween = get_tree().create_tween()
	vanish_tween.tween_property(self, "color_poly:modulate:a", 0, vanish_time).set_ease(Tween.EASE_IN).set_trans(Tween.TRANS_CIRC)
	
	# na koncu animacije sledi KVEFRI in ostalo
	

func die_to_wall():
	
	current_state = States.WALL
	
	var random_animation_index = randi() % 5 + 1
	var random_animation_name: String = "die_stray_%s" % random_animation_index
	animation_player.play(random_animation_name) 
	
	# na koncu animacije sledi ostalo
	
	
# MOVEMENT ------------------------------------------------------------------------------------------------------
	
	
func step(step_direction: Vector2 = Vector2.DOWN):
	
	if not current_state == States.IDLE:
		return
		
	var current_collider = detect_collision_in_direction(step_direction)
	
	if current_collider:
		step_attempt += 1
		if step_attempt < 5:
			var new_direction = step_direction.rotated(deg2rad(90))
			step(new_direction)
			step_attempt = 1
		return
	
	current_state = States.MOVING
	
	collision_shape_ext.position = step_direction * cell_size_x # vržem koližn v smer premika
	
	var step_time: float = 0.2
	
	var step_tween = get_tree().create_tween().set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_IN_OUT)	
	step_tween.tween_property(self, "position", global_position + step_direction * cell_size_x, step_time)
	step_tween.parallel().tween_property(collision_shape_ext, "position", Vector2.ZERO, step_time)
	step_tween.tween_callback(self, "end_move")


func push_stray(push_direction: Vector2, push_cock_time: float, push_time: float):
	
	current_state = States.MOVING
	var stray_move_time: float = 0.08
	var heavier_hit_delay: float = 0.05  # z delayom je porinek bolj pristen in "težak"
	
	var push_tween = get_tree().create_tween()
	# ko napnem plejerja
	push_tween.tween_property(collision_shape_ext, "position", - push_direction * cell_size_x, push_cock_time).set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_OUT) # animiram simultano s premikom plejerja
	# spustim
	push_tween.tween_property(collision_shape_ext, "position", Vector2.ZERO, push_time).set_trans(Tween.TRANS_EXPO).set_ease(Tween.EASE_IN) # vrnem jo na 0 pozicijo
	push_tween.tween_callback(collision_shape_ext, "set_position", [push_direction * cell_size_x]) # potem jo takoj vržem pred straja, da zaščiti premik naprej
	push_tween.tween_property(self, "position", global_position + push_direction * cell_size_x, stray_move_time).set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_OUT).set_delay(heavier_hit_delay)
	push_tween.parallel().tween_property(collision_shape_ext, "position", Vector2.ZERO, stray_move_time).set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_OUT).set_delay(heavier_hit_delay)
	push_tween.tween_callback(self, "end_move")
	
	
func pull_stray(pull_direction: Vector2, pull_cock_time: float, pull_time: float):
	
	current_state = States.MOVING

	var pull_tween = get_tree().create_tween().set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_IN_OUT)
	pull_tween.tween_property(collision_shape_ext, "position", pull_direction * cell_size_x, pull_cock_time) # collision_ext v smer premika (animiram s premikom plejerja)
	pull_tween.tween_property(self, "position", global_position + pull_direction * cell_size_x, pull_time)#.set_delay(pull_time)
	pull_tween.parallel().tween_property(collision_shape_ext, "position", Vector2.ZERO, pull_time) # stray ext shape
	pull_tween.tween_callback(self, "end_move")


func end_move():
	
	if current_state == States.MOVING: # da se stanje resetira samo če ni DYING al pa WALL
		current_state = States.IDLE
	global_position = Global.snap_to_nearest_grid(self)
	
	
# UTILITI ------------------------------------------------------------------------------------------------------


func get_position_indicator_position(current_camera: Camera2D):
	
	var viewport_position = get_viewport_rect().position
	var viewport_size = get_viewport_rect().end
	var current_camera_position = current_camera.get_camera_screen_center()
	
	var camera_edge_clamp_down_x = current_camera_position.x - viewport_size.x/2 + cell_size_x/2 # polovička vp-ja na vsako stran centra kamere
	var camera_edge_clamp_up_x = current_camera_position.x + viewport_size.x/2 - cell_size_x/2
	var camera_edge_clamp_down_y = current_camera_position.y - viewport_size.y/2 + cell_size_x/2 # polovička vp-ja na vsako stran centra kamere
	var camera_edge_clamp_up_y = current_camera_position.y + viewport_size.y/2 - cell_size_x/2
		
	position_indicator.global_position = global_position
	position_indicator.global_position.x = clamp(position_indicator.global_position.x, camera_edge_clamp_down_x, camera_edge_clamp_up_x)
	position_indicator.global_position.y = clamp(position_indicator.global_position.y, camera_edge_clamp_down_y, camera_edge_clamp_up_y)
	

func play_sound(effect_for: String):
	
	if Global.sound_manager.game_sfx_set_to_off:
		return
		
	match effect_for:
		"turning_color":
			var random_blink_index = randi() % $Sounds/Blinking.get_child_count()
			$Sounds/Blinking.get_child(random_blink_index).play() # nekateri so na mute, ker so drugače prepogosti soundi
		"blinking":
			var random_blink_index = randi() % $Sounds/Blinking.get_child_count()
			$Sounds/Blinking.get_child(random_blink_index).play() # nekateri so na mute, ker so drugače prepogosti soundi
			if current_state == States.DYING: # da se ne oglaša ob obračanju v steno
				var random_static_index = randi() % $Sounds/BlinkingStatic.get_child_count()
				$Sounds/BlinkingStatic.get_child(random_static_index).play()
		"stepping":
			var random_step_index = randi() % $Sounds/Stepping.get_child_count()
			var selected_step_sound = $Sounds/Stepping.get_child(random_step_index).play()


func get_neighbor_strays_on_hit(): # kliče player on hit
	
	var directions_to_check: Array = [Vector2.UP, Vector2.DOWN, Vector2.LEFT, Vector2.RIGHT]
	var current_cell_neighbors: Array
	
	for direction in directions_to_check:
		var neighbor = detect_collision_in_direction(direction)
		if neighbor and neighbor.is_in_group(Global.group_strays) and not neighbor == self: # če je kolajder, je stray in ni self
			if not neighbor.current_state == neighbor.States.DYING:# # če je vstanju umiranja se ne šteje za soseda
#			if not neighbor.current_state == neighbor.States.DYING and not neighbor.current_state == neighbor.States.WALL: # če je vstanju umiranja se ne šteje za soseda
				current_cell_neighbors.append(neighbor)
				
	return current_cell_neighbors # uporaba v stalnem čekiranj sosedov

	
func detect_collision_in_direction(direction_to_check):
	
	# obrnem vision grupo v smeri...
	vision.look_at(global_position + direction_to_check)
	
	# vsi ray gledajo naravnost
	for ray in vision_rays:
		ray.cast_to = Vector2(45, 0) # en pixel manj kot 48, da ne seže preko celice
	
	# grebanje kolajderja	
	var first_collider: Node2D
	for ray in vision_rays:
		ray.add_exception(self)
		ray.force_raycast_update()
		if ray.is_colliding():
			first_collider = ray.get_collider()
			break # ko je kolajder neham čekirat
	
	return first_collider


func fade_position_indicator(fade_in: bool):
	
	var fade_time: float = 0.2
	var fade_tween = get_tree().create_tween()
	if fade_in:
		fade_tween.tween_callback(position_indicator, "show")
		fade_tween.tween_property(position_indicator_poly, "modulate:a", 1, 0.5).from(0.0)
	else:
		fade_tween.tween_property(position_indicator_poly, "modulate:a", 0, 0.5)
		fade_tween.tween_callback(position_indicator, "hide")
		

# SIGNALI ------------------------------------------------------------------------------------------------------


func _on_VisibilityNotifier2D_viewport_entered(viewport: Viewport) -> void:
	
	Global.strays_on_screen.append(self)
	visible_on_screen = true
	show()
		
		
func _on_VisibilityNotifier2D_viewport_exited(viewport: Viewport) -> void:
	
	Global.strays_on_screen.erase(self)
	visible_on_screen = false
	hide()


func _on_AnimationPlayer_animation_finished(anim_name: String) -> void:
	
	var die_animations: Array = ["die_stray", "die_stray_1", "die_stray_2", "die_stray_3", "die_stray_4", "die_stray_5", ]
	
	if die_animations.has(anim_name):
		# če postane stena
		if current_state == States.WALL: 
			# wall color
			modulate.a = 1
			color_poly.modulate = Global.color_white_pixel
			# ugasni delovanje
			set_physics_process(false)
			collision_shape_ext.disabled = true	
			position_indicator.modulate.a = 0
		# če umrje
		else: 
			collision_shape.set_deferred("disabled", true)
			collision_shape_ext.set_deferred("disabled", true)
			# odstrani barve iz huda in igre
			Global.game_manager.on_stray_die(self)
			call_deferred("queue_free")


func _on_OverspawnDetect_body_entered(body: Node) -> void: # varovalka overspawn III ... če detect area zazna kolizijo
	# samo na štartu ... ob prikazu jo izklopim
	if body.is_in_group(Global.group_strays) and not body == self:
		printt ("overspawn III on stray - stray area", self)
		call_deferred("queue_free")
	if body.is_in_group(Global.group_players):
		printt ("overspawn III on player - stray area", self)
		call_deferred("queue_free")


func _on_Stray_tree_exiting() -> void:
	
	Global.game_manager.strays_in_game_count = - 1


func _on_Stray_tree_entered() -> void:
	
	Global.game_manager.strays_in_game_count = 1
	
	for stray in get_tree().get_nodes_in_group(Global.group_strays):
		if stray.global_position == global_position:
			printt ("overspawn II on stray - stray tree entered", self) 
			call_deferred("queue_free")
			return
			
	for player in get_tree().get_nodes_in_group(Global.group_players):
		if player.global_position == global_position:
			printt ("overspawn II on player - stray tree entered", self) 
			call_deferred("queue_free")
			return
