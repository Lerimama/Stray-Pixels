extends Node


var home_scene_path: String = "res://scenes/Home.tscn"
var game_scene_path: String = "res://scenes/Game.tscn"
onready var animation_player: AnimationPlayer = $AnimationPlayer


func _on_PlayBtn_pressed() -> void:
	animation_player.play("main_out")

	
func _load_game():
	Global.switch_to_scene(game_scene_path)


