#extends Control
extends GameHud


onready var level_up_popup: Control = $Popups/LevelUp


func _process(delta: float) -> void:
	# namen: update level label
	
	astray_counter.text = "%03d" % Global.game_manager.strays_in_game_count
	picked_counter.text = "%03d" % Global.game_manager.strays_cleaned_count

	# level label show on fill
	if Global.game_manager.game_data.has("level"):
		if not level_label.visible:
			level_label.visible = true	
		level_label.text = "%02d" % Global.game_manager.game_data["level"]
	
	
func set_hud(players_count: int): # kliče main na game-in
	# namen: ikone v player statline, samo 1 player, ni lajfov, ni energije, level data je vis tudi če je prazen, energy counter

	# players
	p1_label.visible = false
	p2_statsline.visible = false
	strays_counters_holder.visible = false
	
	# if Global.game_manager.game_data["game"] == Profiles.Games.SLIDER:
	p1_color_holder.visible = false	

	# popups
	p1_energy_warning_popup = $Popups/EnergyWarning/Solo	

	# lajf counter
	if Global.game_manager.game_settings["player_start_life"] == 1:
		p1_life_counter.visible = false
	else:
		p1_life_counter.visible = true

	# energy counter
	if Global.game_manager.game_data["game"] == Profiles.Games.SCROLLER:
		p1_energy_counter.visible = false
	if Global.game_manager.game_data["game"] == Profiles.Games.SLIDER:
		p1_energy_counter.visible = true

	# level label
	if not Global.game_manager.game_data.has("level"):
		level_label.visible = false

	# glede na to kaj šteje ...
	if current_gamed_hs_type == Profiles.HighscoreTypes.NO_HS:
		highscore_label.visible = false
	elif current_gamed_hs_type == Profiles.HighscoreTypes.HS_TIME_HIGH or Global.game_manager.game_data["highscore_type"] == Profiles.HighscoreTypes.HS_TIME_LOW:
		p1_points_holder.visible = false
		highscore_label.visible = true
		set_current_highscore()
	elif current_gamed_hs_type == Profiles.HighscoreTypes.HS_POINTS:
		p1_points_holder.visible = true
		highscore_label.visible = true
		set_current_highscore()
	elif current_gamed_hs_type == Profiles.HighscoreTypes.HS_COLORS:
		p1_points_holder.visible = false
		p1_color_holder.visible = true
		highscore_label.visible = true
		set_current_highscore()
	
	
func level_up_popup_in(level_reached: int):
	
	level_up_popup.get_node("Label").text = "LEVEL %s" % str(level_reached)
	level_up_popup.show()
	level_up_popup.modulate.a = 0
	
	var popup_in = get_tree().create_tween()
	popup_in.tween_property(level_up_popup, "modulate:a", 1, 0.3)


func level_up_popup_out():
	
	var popup_in = get_tree().create_tween()
	popup_in.tween_property(level_up_popup, "modulate:a", 0, 0.3)
	popup_in.tween_callback(level_up_popup, "hide")
				
						
func fade_in_instructions_popup(in_time: float):
	# namen: prilagojena navodila
	
	$Popups/Instructions/Controls.show()
	$Popups/Instructions/ControlsDuel.hide()
	title.text = Global.game_manager.game_data["game_name"]
	
	if Global.game_manager.game_data["game"] == Profiles.Games.SCROLLER:
		win_label.text = "Collect colors to progress through all 10 levels."
		instructions_label.text = "Game is over when first wall column reaches the top or you have no room to move."
		instructions_label_2.text = "Energy and speed are constant."
		instructions_label_3.text = "Bursting always collects all colors in stack."
		instructions_label_4.text = "Skills are not available."
		instructions_label_5.text = "Time is unlimited."
		instructions_label_6.text = "Highscore is the highest points total."
	elif Global.game_manager.game_data["game"] == Profiles.Games.SLIDER:
		win_label.text = "Collect colors to progress through all 10 levels."
		instructions_label.text = "Game is over when you are out of energy."
		instructions_label_2.text = "Energy depletes with travelling, touching stray pixels or hitting a wall."
		instructions_label_3.text = "Bursting always collects all colors in stack."
		instructions_label_4.text = "Skills are not available."
		instructions_label_5.text = "Time is unlimited."
		instructions_label_6.text = "Highscore is the highest points total."
					
	var show_instructions_popup = get_tree().create_tween()
	show_instructions_popup.tween_callback(instructions_popup, "show")
	show_instructions_popup.tween_property(instructions_popup, "modulate:a", 1, in_time).from(0.0).set_ease(Tween.EASE_IN)


# SPECTRUM ---------------------------------------------------------------------------------------------------------------------------


func spawn_color_indicators(available_colors: Array): # kliče GM
	# namen: moduliram
	var indicator_index = 0 # za fiksirano zaporedje
	
	for color in available_colors:
		indicator_index += 1 
		# spawn indicator
		var new_color_indicator = ColorIndicator.instance()
		new_color_indicator.color = color
		
		new_color_indicator.modulate.a = 0.3
		spectrum.add_child(new_color_indicator)
		active_color_indicators.append(new_color_indicator)


func empty_color_indicators():
	
	# zbrišem trenutne indikatorje
	for child in spectrum.get_children():
		child.queue_free()
	active_color_indicators.clear()
	
	
func update_indicator_on_stage_up(current_stage: int): 
	
	# current stage ni pomemben, ker zmeraj obarvam prvega v aktivnih
	# obarvam indikator
	if not active_color_indicators.empty(): # zazih
		var current_indicator = active_color_indicators.front()
		current_indicator.modulate.a = 1
		# izbris iz aktivnih indikatorjev
		active_color_indicators.pop_front()

					
func show_color_indicator(picked_color: Color):

	return # player kliče, ampak v scrollerju se nič ne zgodi


func check_for_warning(player_stats: Dictionary, warning_popup: Control):
	# namen drugače prikaže in čekira
	return
	
	if warning_popup:
		var steps_remaining_label: Label
		steps_remaining_label = warning_popup.get_node("StepsRemaining")
		if player_stats["player_energy"] < Global.game_manager.game_settings["player_tired_energy"] and not player_stats["player_energy"] <= 0:
			steps_remaining_label.text = "LOW ENERGY WARNING!"
			if warning_popup.visible == false:
				warning_in(warning_popup)
		elif player_stats["player_energy"] > Global.game_manager.game_settings["player_tired_energy"]:
			if warning_popup.visible == true:
				warning_out(warning_popup)
		elif player_stats["player_energy"] <= 0:
			if warning_popup.visible == true:
				warning_out(warning_popup)		


func _on_StartButton_pressed() -> void:
	pass # Replace with function body.
