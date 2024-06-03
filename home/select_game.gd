extends Control


onready var animation_player: AnimationPlayer = $"%AnimationPlayer"
onready var sweeper_game_btn: Button = $GamesMenu/Sweeper/SweeperBtn
onready var sweeper_btns_count: int = $"../SelectLevel/BtnsHolder".get_child_count() # za število ugank
onready var sweeper_label: Label = $GamesMenu/Sweeper/Label
onready var color_pool: Array = $"%Intro".all_colors_available
onready var tutorial_mode_btn: CheckButton = $GamesMenu/Classic/TutorialModeBtn


func _ready() -> void:
	
	if Profiles.tutorial_mode:
		tutorial_mode_btn.pressed = true
	else:
		tutorial_mode_btn.pressed = false
	
	sweeper_label.text %= sweeper_btns_count


func _process(delta: float) -> void:
	
	if get_parent().current_screen == get_parent().Screens.SELECT_GAME:
		
		# barvam ozadje gumbov na focus
		var unfocused_color = Global.color_almost_black_pixel
		var focused_btn: BaseButton = get_focus_owner()
		if focused_btn.name == "ClassicBtn": # bug ... razdeljen v dva ifa barvanje tutorial gumba
			$GamesMenu/Classic/Background.color = Global.color_almost_white_text
			$GamesMenu/Classic/Label2.modulate = Global.color_dark_gray_pixel
			$GamesMenu/Classic/ClassicBtn.modulate = Global.color_dark_gray_pixel
			$GamesMenu/Classic/TutorialModeBtn.set("custom_colors/font_color_pressed", Global.color_dark_gray_pixel)
			#			$GamesMenu/Classic/TutorialModeBtn.call_deferred("release_focus")
		elif focused_btn.name == "TutorialModeBtn":
			$GamesMenu/Classic/Background.color = Global.color_almost_white_text
			$GamesMenu/Classic/Label2.modulate = Global.color_dark_gray_pixel
			$GamesMenu/Classic/ClassicBtn.modulate = Global.color_dark_gray_pixel			
			$GamesMenu/Classic/TutorialModeBtn.set("custom_colors/font_color_pressed", Global.color_dark_gray_pixel)
		else:
			$GamesMenu/Classic/Background.color = unfocused_color
			$GamesMenu/Classic/Label2.modulate = Color.white
			$GamesMenu/Classic/ClassicBtn.modulate = Color.white
			$GamesMenu/Classic/TutorialModeBtn.set("custom_colors/font_color_pressed", Color.white)
		if focused_btn.name == "CleanerSBtn" or focused_btn.name == "CleanerMBtn" or focused_btn.name == "CleanerLBtn":
			$GamesMenu/Cleaner/Background.color = Global.color_blue
			$GamesMenu/Cleaner/Background.modulate.a = 0.95 # da ne žari premočno
		else:
			$GamesMenu/Cleaner/Background.color = unfocused_color
			$GamesMenu/Cleaner/Background.modulate.a = 1
		if focused_btn.name == "EraserBtn" or focused_btn.name == "HandlerBtn" or focused_btn.name == "DefenderBtn":
			$GamesMenu/Timeless/Background.color = Global.color_green
			$GamesMenu/Timeless/Background.modulate.a = 0.83 # da ne žari premočno
		else:
			$GamesMenu/Timeless/Background.color = unfocused_color
			$GamesMenu/Timeless/Background.modulate.a = 1
		if focused_btn.name == "TheDuelBtn":
			$GamesMenu/TheDuel/Background.color = Global.color_red
			$GamesMenu/TheDuel/Background.modulate.a = 0.88 # da ne žari premočno
		else:
			$GamesMenu/TheDuel/Background.color = unfocused_color
			$GamesMenu/TheDuel/Background.modulate.a = 1
		if focused_btn.name == "SweeperBtn":
			$GamesMenu/Sweeper/Background.color = Global.color_purple
			$GamesMenu/Sweeper/Background.modulate.a = 0.85 # da ne žari premočno
		else:
			$GamesMenu/Sweeper/Background.color = unfocused_color
			$GamesMenu/Sweeper/Background.modulate.a = 1
	
			
func play_selected_game(selected_game_enum: int):
	
	Profiles.set_game_data(selected_game_enum)
	Global.sound_manager.play_gui_sfx("menu_fade")
	animation_player.play("play_game")
	get_viewport().set_disable_input(true)
	
				
func _on_BackBtn_pressed() -> void:
	
	Global.sound_manager.play_gui_sfx("screen_slide")
	animation_player.play_backwards("select_game")
	get_viewport().set_disable_input(true)
	
	
func _on_ClassicBtn_pressed() -> void:
	
	play_selected_game(Profiles.Games.CLASSIC)
	
func _on_TutorialModeBtn_toggled(button_pressed: bool) -> void:
	
	if button_pressed:
		Profiles.tutorial_mode = true
	else:
		Profiles.tutorial_mode = false
		
func _on_CleanerSBtn_pressed() -> void:
	
	play_selected_game(Profiles.Games.CLEANER_S)
	
	
func _on_CleanerMBtn_pressed() -> void:
	
	play_selected_game(Profiles.Games.CLEANER_M)
	
	
func _on_CleanerLBtn_pressed() -> void:
	
	play_selected_game(Profiles.Games.CLEANER_L)
	
	
func _on_EraserBtn_pressed() -> void:
	
	play_selected_game(Profiles.Games.ERASER)
	
	
func _on_HandlerBtn_pressed() -> void:
	
	play_selected_game(Profiles.Games.HANDLER)
	
	
func _on_DefenderBtn_pressed() -> void:
	
	play_selected_game(Profiles.Games.DEFENDER)
	
	
func _on_TheDuelBtn_pressed() -> void:
	
	play_selected_game(Profiles.Games.THE_DUEL)
	
	
func _on_SweeperBtn_pressed() -> void:
	
	Global.sound_manager.play_gui_sfx("screen_slide")
	animation_player.play("select_level")
	get_viewport().set_disable_input(true)


func _on_ClassicBackground_mouse_entered() -> void:
	
	# če še ni izbran kateri v trenutnem boxu
	if not $GamesMenu/Classic/ClassicBtn.has_focus() and not tutorial_mode_btn.has_focus():
		$GamesMenu/Classic/ClassicBtn.grab_focus()
	
	
func _on_CleanerBackground_mouse_entered() -> void:
	
	# če še ni izbran kateri v trenutnem boxu
	if not $GamesMenu/Cleaner/CleanerMBtn.has_focus() and not $GamesMenu/Cleaner/CleanerLBtn.has_focus():
		$GamesMenu/Cleaner/CleanerSBtn.grab_focus()
		
		
func _on_TimelessBackground_mouse_entered() -> void:
	
	# če še ni izbran kateri v trenutnem boxu
	if not $GamesMenu/Timeless/DefenderBtn.has_focus() and not $GamesMenu/Timeless/HandlerBtn.has_focus():
		$GamesMenu/Timeless/EraserBtn.grab_focus()
		
		
func _on_SweeperBackground_mouse_entered() -> void:
	
	sweeper_game_btn.grab_focus()
	
	
func _on_DuelBackground_mouse_entered() -> void:
	
	$GamesMenu/TheDuel/TheDuelBtn.grab_focus()
