extends Control

onready var sweeper_btn: Button = $GameBtns/RiddlerBtn
onready var animation_player: AnimationPlayer = $"%AnimationPlayer"

onready var sweeper_btns_holder: Control = $"../SelectLevel/LevelGrid/VBoxContainer/BtnsHolder" # za število ugank
onready var riddle_count: int = sweeper_btns_holder.get_child_count()
onready var sweeper_label: Label = $Riddler/Label


func _on_BackBtn_pressed() -> void:
	
	Global.sound_manager.play_gui_sfx("screen_slide")
	animation_player.play_backwards("select_game")
	get_viewport().set_disable_input(true)
	

func play_selected_game(selected_game_enum: int):
	Profiles.set_game_data(selected_game_enum)
	Global.sound_manager.play_gui_sfx("menu_fade")
	animation_player.play("play_game")
	get_viewport().set_disable_input(true)
	
		
# at the cleaners -----------------------------------------------------------------------------------------


func _on_TutorialBtn_pressed() -> void:
	play_selected_game(Profiles.Games.TUTORIAL)

	
func _on_EraserSBtn_pressed() -> void:
	play_selected_game(Profiles.Games.CLEANER_S)
func _on_EraserMBtn_pressed() -> void:
	play_selected_game(Profiles.Games.CLEANER_M)
func _on_EraserLBtn_pressed() -> void:
	play_selected_game(Profiles.Games.CLEANER_L)


func _on_CleanerSBtn_pressed() -> void:
	play_selected_game(Profiles.Games.ERASER)
	
func _on_CleanerMBtn_pressed() -> void:
	play_selected_game(Profiles.Games.HANDLER)
	
	
func _on_ScrollerBtn_pressed() -> void:
	play_selected_game(Profiles.Games.DEFENDER)


func _on_TheDuelBtn_pressed() -> void:
	play_selected_game(Profiles.Games.THE_DUEL)


func _on_Enigma_Btn_pressed() -> void:
	Global.sound_manager.play_gui_sfx("screen_slide")
	animation_player.play("select_riddler_level")
	get_viewport().set_disable_input(true)
