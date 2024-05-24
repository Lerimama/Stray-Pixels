extends PlayerOrig


var detect_touch_pause_time: float = 1
var recheck_touch_pause_time: float = 5 # ker merim, kdaj si obkoljen za vedno, je to tudi čas pavze do GO klica ... more bit večje od časa stepanja
var is_surrounded: bool
var surrounded_player_strays: Array # za preverjanje prek večih preverjanj
onready var touch_timer: Timer = $Touch/TouchTimer


#func _physics_process(delta: float) -> void:
#
#	detect_touch()
	
	
func idle_inputs():
	# namen: odstranim SKILLED stanje, dodam surrounded setanje
	
	# preveri vse štiri smeri
	var directions_to_check: Array = [Vector2.UP, Vector2.DOWN, Vector2.LEFT, Vector2.RIGHT]
	var direction_with_collision: Array
	for direction in directions_to_check:
		var current_collider = detect_collision_in_direction(direction)
		if current_collider:
			direction_with_collision.append(direction)
	
	# če so vse štiri polne je gejm over
	if direction_with_collision.size() == directions_to_check.size():
		yield(get_tree().create_timer(1),"timeout")
		player_stats["player_energy"] = 0
	
	
	if player_stats["player_energy"] > 1:
		var current_collider: Node2D = detect_collision_in_direction(direction)
		if not current_collider:
		# dokler ne zazna kolizije se premika zvezno ... is_action_pressed
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
		else:
			end_move()

	if Input.is_action_just_pressed(key_burst): # brez "just" dela po stisku smeri ... ni ok
		current_state = States.COCKING
		if change_color_tween and change_color_tween.is_running(): # če sprememba barve še poteka, jo spremenim takoj
			change_color_tween.kill()
			pixel_color = change_to_color
		burst_light_on()
			
					
func cocking_inputs():

	# cocking
	# varianta na short cock
	
	if Input.is_action_pressed(key_up):
		if cocked_ghosts.empty(): # če je smer setana, ni pa potrjena
			direction = Vector2.DOWN
		if direction == Vector2.DOWN: # če je smer setana (ista)
			cock_burst()
	elif Input.is_action_pressed(key_down):
		if cocked_ghosts.empty():
			direction = Vector2.UP
		if direction == Vector2.UP:
			cock_burst()
	elif Input.is_action_pressed(key_left):
		if cocked_ghosts.empty():
			direction = Vector2.RIGHT
		if direction == Vector2.RIGHT:
			cock_burst()
	elif Input.is_action_pressed(key_right):
		if cocked_ghosts.empty():
			direction = Vector2.LEFT
		if direction == Vector2.LEFT:
			cock_burst()

	# releasing		
	if Input.is_action_just_released(key_burst):
		if cocked_ghosts.empty():
			end_move()
		else:
			release_burst()
			burst_light_off()
			

func spawn_cock_ghost(cocking_direction: Vector2): 
	# namen: vsi cock ghosti polni barve, zaznavanje cock_room z deffered klicom (da lahko bolje zazna cock room)
	
	var cocked_ghost_alpha: float = 1 # najnižji alfa za ghoste ... old 0.55
	var cocked_ghost_alpha_divider: float = 5 # faktor nižanja po zaporedju (manjši je bolj oster) ... old 14
	
	# spawn ghosta pod manom
	var cock_ghost_position = (global_position - cocking_direction * cell_size_x/2) + (cocking_direction * cell_size_x * (cocked_ghosts.size() + 1)) # +1, da se ne začne na pixlu
	var new_cock_ghost = spawn_ghost(cock_ghost_position)
	new_cock_ghost.z_index = 3 # nad straysi in playerjem
	new_cock_ghost.modulate.a  = cocked_ghost_alpha - (cocked_ghosts.size() / cocked_ghost_alpha_divider)
	new_cock_ghost.direction = cocking_direction
	
	# v kateri smeri je scale
	if direction.y == 0: # smer horiz
		new_cock_ghost.scale.x = 0
	elif direction.x == 0: # smer ver
		new_cock_ghost.scale.y = 0

	# animiram cock celico
	var cock_cell_tween = get_tree().create_tween()
	cock_cell_tween.tween_property(new_cock_ghost, "scale", Vector2.ONE, cock_ghost_cocking_time).set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_OUT)
	cock_cell_tween.parallel().tween_property(new_cock_ghost, "position", global_position + cocking_direction * cell_size_x * (cocked_ghosts.size() + 1), cock_ghost_cocking_time).set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_OUT)
	
	# ray detect velikost je velikost napenjanja
	new_cock_ghost.ghost_ray.cast_to = direction * cell_size_x
	new_cock_ghost.connect("ghost_detected_body", self, "_on_ghost_detected_body")
	
	return new_cock_ghost


func show_ghost(ghost):
	
	if cocking_room:
		var cock_cell_tween = get_tree().create_tween()
		cock_cell_tween.tween_property(ghost, "modulate:a", 1, cock_ghost_cocking_time)
			

func burst():
	# namen: konstantna hitrost bursta (neodvisna od vrednosti cocka)
	
	var burst_direction = direction
	var backup_direction = - burst_direction
	var current_ghost_count = cocked_ghosts.size()
	
	var new_stretch_ghost: Node
	
	# spawn stretch ghost
	new_stretch_ghost = spawn_ghost(global_position)
	new_stretch_ghost.color_poly.hide()
	new_stretch_ghost.color_poly_alt.show()
	if burst_direction.y == 0: # če je smer hor
		new_stretch_ghost.scale = Vector2(current_ghost_count, 1)
	elif burst_direction.x == 0: # če je smer ver
		new_stretch_ghost.scale = Vector2(1, current_ghost_count)
	new_stretch_ghost.position = global_position - (burst_direction * cell_size_x * current_ghost_count)/2 - burst_direction * cell_size_x/2

	# release cocked ghosts
	while not cocked_ghosts.empty():
		var ghost = cocked_ghosts.pop_back()
		ghost.queue_free()
	
	play_sound("burst")
	
	# release strech ghost 
	var strech_ghost_shrink_time: float = 0.1 # original je bila 0.2
	var release_tween = get_tree().create_tween()
	release_tween.tween_property(new_stretch_ghost, "scale", Vector2.ONE, strech_ghost_shrink_time).set_trans(Tween.TRANS_QUINT).set_ease(Tween.EASE_IN)
	release_tween.parallel().tween_property(new_stretch_ghost, "position", global_position - burst_direction * cell_size_x, strech_ghost_shrink_time).set_trans(Tween.TRANS_QUINT).set_ease(Tween.EASE_IN)
	release_tween.tween_callback(new_stretch_ghost, "queue_free")
	yield(release_tween, "finished")		
	# release pixel
	current_state = States.BURSTING
	#	burst_speed = current_ghost_count * cock_ghost_speed_addon
	#	if current_ghost_count < cocked_ghost_max_count and not current_ghost_count == 0:
	#		burst_speed = 2 * cock_ghost_speed_addon
	#	else:
	burst_speed = 3 * cock_ghost_speed_addon
	change_stat("burst_released", 1)
	
	
func play_sound(effect_for: String):
	# namen: brez vrtoglavice hit wall
	
	if Global.sound_manager.game_sfx_set_to_off:
		return	
		
	match effect_for:
		"blinking":
			var random_blink_index = randi() % $Sounds/Blinking.get_child_count()
			$Sounds/Blinking.get_child(random_blink_index).play() # nekateri so na mute, ker so drugače prepogosti soundi
			var random_static_index = randi() % $Sounds/BlinkingStatic.get_child_count()
			$Sounds/BlinkingStatic.get_child(random_static_index).play()
		"heartbeat":
			$Sounds/Heartbeat.play()
		# bursting
		"hit_stray":
			$Sounds/Burst/HitStray.play()
		"hit_wall":
			$Sounds/Burst/HitWall.play()
		#			$Sounds/Burst/HitDizzy.play()
		"burst":
			yield(get_tree().create_timer(0.1), "timeout")
			$Sounds/Burst/Burst.play()
			$Sounds/Burst/BurstLaser.play()
		"burst_cocking":
			if $Sounds/Burst/BurstCocking.is_playing():
				return
			$Sounds/Burst/BurstCocking.play()
		"burst_uncocking":
			if $Sounds/Burst/BurstUncocking.is_playing():
				return
			$Sounds/Burst/BurstUncocking.play()			
		"burst_stop":
			$Sounds/Burst/BurstStop.play()
		# skills
		"pushpull_start":
			$Sounds/Skills/PushPull.play()
		"pushpull_end":
			$Sounds/Skills/PushedPulled.play()
		"pulled":
			$Sounds/Skills/StoneSlide.play()
		"pushed":
			$Sounds/Skills/Cling.play()
			$Sounds/Skills/StoneSlide.play()
		"teleport":
			$Sounds/Skills/TeleportIn.play()
	

			
func on_hit_stray(hit_stray: KinematicBody2D):
	# namen: always full stack, tudi sprožanje čekiranja levelov, preverjanje straysov na podnu, on wall hit preusmeritev
	# možno: plejer ostane bel
	
	if hit_stray.current_state == hit_stray.States.WALL:
		on_hit_wall()
		return
		
	Input.start_joy_vibration(0, 0.5, 0.6, 0.2)
	play_sound("hit_stray")	
	spawn_collision_particles()
	shake_player_camera(burst_speed)			

	if hit_stray.current_state == hit_stray.States.DYING or hit_stray.current_state == hit_stray.States.WALL: # če je že v umiranju, samo kolajdaš
		end_move()
		return
	
	# izklopim če začne bel
	tween_color_change(hit_stray.stray_color)
	
	# preverim sosede
	var hit_stray_neighbors: Array = check_strays_neighbors(hit_stray)
	var all_neighboring_strays: Array = hit_stray_neighbors[0]
	var white_strays_in_stack: Array = hit_stray_neighbors[1]
	
	# naberem strayse za destrojat
	var burst_speed_units_count = burst_speed / cock_ghost_speed_addon
	var strays_to_destroy: Array = []
	strays_to_destroy.append(hit_stray)
	# na seznam za destroj
	if not all_neighboring_strays.empty():
		for neighboring_stray in all_neighboring_strays: # še sosedi glede na moč bursta
#			if strays_to_destroy.size() < burst_speed_units_count or burst_speed_units_count == cocked_ghost_max_count:
#				strays_to_destroy.append(neighboring_stray)
#			else: 
#				break
			strays_to_destroy.append(neighboring_stray)

	# jih destrojam
	for stray in strays_to_destroy:
		var stray_index = strays_to_destroy.find(stray)
		stray.die(stray_index, strays_to_destroy.size()) # podatek o velikosti rabi za izbor animacije
	
	# stats
	var strays_not_walls_count: int = strays_to_destroy.size() - white_strays_in_stack.size()
	change_stat("hit_stray", [strays_not_walls_count, white_strays_in_stack.size()]) 
				
	end_move() # more bit za collision partikli zaradi smeri

		
func on_hit_wall():
	# namen: drugačni efekti, nepošiljanje statistike in end_move()
	
	Input.start_joy_vibration(0, 0.5, 0.6, 0.7)
	play_sound("hit_wall")
	# spawn_dizzy_particles()
	spawn_collision_particles()
	shake_player_camera(burst_speed)
	
	end_move()


func detect_touch():
	
	var touch_areas: Array = [$Touch/TouchArea, $Touch/TouchArea2, $Touch/TouchArea3, $Touch/TouchArea4]
	var current_player_strays: Array # sosedi v tem koraku
		
	# preverim vsako areo, če ima straysa
	var touching_sides_count: int = 0
	for area in touch_areas:
		var bodies_touched: Array = area.get_overlapping_bodies()
		if not bodies_touched.empty():
			for body in bodies_touched:
				if body.is_in_group(Global.group_strays):
					current_player_strays.append_array(bodies_touched)
					touching_sides_count += 1
					break
	
	# surrounded
	if touching_sides_count == touch_areas.size():
		# če je še vedno obkoljen, preverim pe istost sosedov > GO
		if is_surrounded:
			# če so sosedi isti je GO
			if surrounded_player_strays == current_player_strays:
				Global.game_manager.game_over(Global.game_manager.GameoverReason.LIFE)
			# če niso isti, restiram sosede in potem normalno naprej
			else:
				surrounded_player_strays = []
				is_surrounded = false
				touch_timer.start(detect_touch_pause_time)
		# če je prvič obkoljen, ga označim za obkoljenega in zapišem sosede
		else: 
			is_surrounded = true
			surrounded_player_strays = current_player_strays
			touch_timer.start(recheck_touch_pause_time) # daljši čas
	# not surrounded
	else:
		surrounded_player_strays = []
		is_surrounded = false # resetiram
		touch_timer.start(detect_touch_pause_time)


func _on_TouchTimer_timeout() -> void:
	
	detect_touch() # za GO
