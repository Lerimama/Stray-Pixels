extends GameOver


onready var timeup_label: Label = $GameoverTitle/ReasonTime/TimeupLabel
onready var sweeper_game_summary: Control = $SweeperGameSummary
onready var sweeper_highscore_table: VBoxContainer = $SweeperGameSummary/HighscoreTable

var sweeper_solved: bool = false				
		
				
func _ready() -> void:
	# namen: dodan enigam game summary
	
	Global.gameover_menu = self
	
	visible = false
	gameover_title_holder.visible = false
	game_summary_holder.visible = false
	name_input_popup.visible = false
	sweeper_game_summary.visible = false
	

func set_game_gameover_title():
	# namen: sprememba teksta v GO - TIME komentarju glede na to katera igra je
	# namen: opredelim, če je bila sweeper rešena
	
	# uganka in je bila rešena
	if Global.game_manager.game_data["game"] == Profiles.Games.SWEEPER:
		if current_gameover_reason == Global.game_manager.GameoverReason.CLEANED:
			Global.data_manager.write_solved_status_to_file(Global.game_manager.game_data)
			selected_gameover_title = gameover_title_cleaned
			selected_gameover_jingle = "win_jingle"
			name_input_label.text = "Great work!"
		else: # GO skrin je na neuspeh vedno LIFE
			selected_gameover_title = gameover_title_life
			selected_gameover_jingle = "lose_jingle"
	else:
		# glede na GO razlog	
		match current_gameover_reason:
			Global.game_manager.GameoverReason.CLEANED:
				selected_gameover_title = gameover_title_cleaned
				selected_gameover_jingle = "win_jingle"
				name_input_label.text = "Great work!"
			Global.game_manager.GameoverReason.LIFE:
				selected_gameover_title = gameover_title_life
				selected_gameover_jingle = "lose_jingle"
				name_input_label.text = "But still ... "
			Global.game_manager.GameoverReason.TIME:
				selected_gameover_title = gameover_title_time
				selected_gameover_jingle = "lose_jingle"
				name_input_label.text = "But still ... "


func show_gameover_menu():
	# namen: sweeper HS table, izločim beleženje HS, če sweeper ni končana,
	
	get_tree().set_pause(true) # setano čez celotno GO proceduro
	
	if players_in_game.size() == 2:
		selected_gameover_menu.visible = false
		selected_gameover_menu.modulate.a = 0
		var fade_in = get_tree().create_tween().set_pause_mode(SceneTreeTween.TWEEN_PAUSE_PROCESS)
		fade_in.tween_callback(selected_gameover_menu, "show")#.set_delay(1)
		fade_in.tween_property(selected_gameover_menu, "modulate:a", 1, 1)
		fade_in.parallel().tween_callback(Global, "grab_focus_no_sfx", [focus_btn])		
	else:	
		
		var current_highscore_type: int = Global.game_manager.game_data["highscore_type"]
		var current_player_ranking: int
		
		if current_highscore_type == Profiles.HighscoreTypes.NO_HS:
			selected_game_summary = game_summary_no_hs
			yield(get_tree().create_timer(1), "timeout") # podaljšam pavzo za branje
			show_game_summary()
		else:
			# če je sweeper score štejem samo, če vse spuca
			if Global.game_manager.game_data["game"] == Profiles.Games.SWEEPER and not current_gameover_reason == Global.game_manager.GameoverReason.CLEANED: 
				yield(get_tree().create_timer(1), "timeout")
				current_player_ranking = 100 # zazih ni na lestvici
			else:
				if score_is_ranking: # manage_gameover_highscores počaka na signal iz name_input
					open_name_input()
					yield(Global.data_manager, "highscores_updated")
					get_viewport().set_disable_input(false) # anti dablklik
					current_player_ranking = Global.data_manager.current_player_ranking
			
			if Global.game_manager.game_data["game"] == Profiles.Games.SWEEPER:
				sweeper_highscore_table.get_highscore_table(Global.game_manager.game_data, current_player_ranking)
			else:
				highscore_table.get_highscore_table(Global.game_manager.game_data, current_player_ranking)
			selected_game_summary = game_summary_with_hs
			show_game_summary()


func show_game_summary():
	# namen: izbira sweeper game summary
	
	var game_summary_to_show: Control
	
	if Global.game_manager.game_data["game"] == Profiles.Games.SWEEPER:
		# focus btn
		if current_gameover_reason == Global.game_manager.GameoverReason.CLEANED:
			focus_btn = sweeper_game_summary.get_node("Menu/NextLevelBtn")
		else:
			focus_btn = sweeper_game_summary.get_node("Menu/RestartBtn")
			
		sweeper_game_summary.get_node("DataContainer/Game").text %= str(Global.game_manager.game_data["game_name"])
		sweeper_game_summary.get_node("DataContainer/Level").text %= "%02d" % Global.game_manager.game_data["level"]
		sweeper_game_summary.get_node("DataContainer/AstrayPixels").text %= str(Global.game_manager.strays_in_game_count)
		sweeper_game_summary.visible = true	
		sweeper_game_summary.modulate.a = 0	
		game_summary_to_show = sweeper_game_summary
	else:
		focus_btn = selected_game_summary.get_node("Menu/RestartBtn")
		selected_game_summary.get_node("DataContainer/Game").text %= str(Global.game_manager.game_data["game_name"])
		if not Global.game_manager.game_data.has("level"):
			selected_game_summary.get_node("DataContainer/Level").hide()
		else:
			selected_game_summary.get_node("DataContainer/Level").text %= str(Global.game_manager.game_data["level"])
		selected_game_summary.get_node("DataContainer/Points").text %= str(p1_final_stats["player_points"])
		selected_game_summary.get_node("DataContainer/Time").text %= str(Global.hud.game_timer.absolute_game_time)
		selected_game_summary.get_node("DataContainer/CellsTraveled").text %= str(p1_final_stats["cells_traveled"])
		selected_game_summary.get_node("DataContainer/BurstCount").text %= str(p1_final_stats["burst_count"])
		selected_game_summary.get_node("DataContainer/SkillsUsed").text %= str(p1_final_stats["skill_count"])
		selected_game_summary.get_node("DataContainer/PixelsOff").text %= str(p1_final_stats["colors_collected"])
		selected_game_summary.get_node("DataContainer/AstrayPixels").text %= str(Global.game_manager.strays_in_game_count)
		selected_game_summary.visible = true	
		game_summary_holder.visible = true	
		game_summary_holder.modulate.a = 0	
		game_summary_to_show = game_summary_holder

	# hide title and name_popup > show game summary
	var cross_fade = get_tree().create_tween().set_pause_mode(SceneTreeTween.TWEEN_PAUSE_PROCESS)
	cross_fade.tween_property(name_input_popup, "modulate:a", 0, 0.5)
	cross_fade.parallel().tween_property(gameover_title_holder, "modulate:a", 0, 1)
	cross_fade.parallel().tween_property(background, "color:a", 1, 1)
	cross_fade.tween_callback(name_input_popup, "hide")
	cross_fade.parallel().tween_callback(gameover_title_holder, "hide")
	cross_fade.parallel().tween_property(game_summary_to_show, "modulate:a", 1, 1)#.set_delay(1)
	cross_fade.tween_callback(Global, "grab_focus_no_sfx", [focus_btn])


func _on_ExitGameBtn_pressed() -> void:
	get_tree().quit()


func _on_NextLevelBtn_pressed() -> void:
	
	var next_level_number: int = Global.game_manager.game_data["level"] + 1
	Profiles.game_data_sweeper["level"] = next_level_number
	Global.main_node.reload_game()
