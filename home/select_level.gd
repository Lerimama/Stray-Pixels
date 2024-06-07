extends Control


var unfocused_color: Color = Global.color_almost_black_pixel
var btn_colors: Array
var solved_sweeper_btns: Array

onready var animation_player: AnimationPlayer = $"%AnimationPlayer"
onready var btn_grid_container: Control = $BtnsHolder
onready var solutions_btn: CheckButton = $SolutionsBtn

onready var all_level_btns: Array# = btn_grid_container.get_children()
onready var LevelBtn: PackedScene = preload("res://home/level_btn.tscn")


func _ready() -> void:
	
	Profiles.game_data_sweeper["level"] = 1 # ni nujno

	set_level_btns()
	connect_level_btns()	

	if Profiles.solution_hint_on:
		solutions_btn.pressed = true
	else:
		solutions_btn.pressed = false
	
	solutions_btn.modulate = Global.color_gui_gray # rešitev, ker gumb se na začetku obarva kot fokusiran	

	# menu btn group
	$BackBtn.add_to_group(Global.group_menu_cancel_btns)
		
		
func set_level_btns():
	
	# zbrišem vzorčne gumbe v holderju
	for btn in btn_grid_container.get_children():
		btn.queue_free()
	
	# spawnam nove gumbe za vsak tilemap_path (vmes preverjam zaporedje glede na ime fileta)
	for n in Profiles.sweeper_level_tilemap_paths.size():
		var level_number_as_string: String = "%02d" % (n + 1)
		for tilemap_path in Profiles.sweeper_level_tilemap_paths:
			if tilemap_path.rfind(level_number_as_string) >= 0:
				var new_level_btn: Button = LevelBtn.instance()
				btn_grid_container.add_child(new_level_btn)
				new_level_btn.add_to_group(Global.group_menu_confirm_btns)
				all_level_btns.append(new_level_btn)
				break
	
	var column_number: int = round(sqrt(Profiles.sweeper_level_tilemap_paths.size()))
	btn_grid_container.columns = column_number
	
	# naberem gumbe in barve
	if Profiles.use_default_color_theme:
		btn_colors = Global.get_spectrum_colors(all_level_btns.size())
	else:			
		var color_split_offset: float = 1.0 / all_level_btns.size()
		for btn_count in all_level_btns.size():
			var color = Global.game_color_theme_gradient.interpolate(btn_count * color_split_offset) # barva na lokaciji v spektrumu
			btn_colors.append(color)	
	
	# poimenujem gumbe in obarvam solved 
	var solved_levels: Array = Global.data_manager.read_solved_status_from_file(Profiles.game_data_sweeper)
	solved_sweeper_btns = []
	for btn in all_level_btns:
		var btn_index: int = all_level_btns.find(btn)
		var btn_level_number: int = btn_index + 1
		# level name
		btn.get_node("VBoxContainer/Label").text = "%02d" % btn_level_number
		# osnovna barva ozadja
		btn.self_modulate = unfocused_color
		# preverim če je rešen
		if btn_level_number in solved_levels:
			solved_sweeper_btns.append(btn)
			btn.get_node("VBoxContainer/Label").modulate = btn_colors[btn_index]
			btn.get_node("VBoxContainer/Solved").modulate = btn_colors[btn_index]
			btn.get_node("VBoxContainer/Solved").show()
		else:
			btn.get_node("VBoxContainer/Label").modulate = Global.color_gui_gray
			btn.get_node("VBoxContainer/Solved").hide()

	
# btns ---------------------------------------------------------------------------------------------


func connect_level_btns():
	
	for btn in btn_grid_container.get_children():
		btn.connect("mouse_entered", self, "_on_btn_hovered_or_focused", [btn])
		btn.connect("focus_entered", self, "_on_btn_hovered_or_focused", [btn])
		btn.connect("focus_exited", self, "_on_btn_unhovered_or_unfocused", [btn])
		# btn.connect("mouse_exited", self, "_on_btn_unhovered_or_unfocused", [btn])
		btn.connect("pressed", self, "_on_btn_pressed", [btn])
		
		
func _on_btn_hovered_or_focused(btn):
	
	btn.self_modulate = btn_colors[all_level_btns.find(btn)]
	btn.get_node("VBoxContainer/Label").modulate = Color.white
	btn.get_node("VBoxContainer/Solved").modulate = Color.white
	
	
func _on_btn_unhovered_or_unfocused(btn):
	
	btn.self_modulate = Global.color_almost_black_pixel
	if solved_sweeper_btns.has(btn):
		btn.get_node("VBoxContainer/Label").modulate = btn_colors[all_level_btns.find(btn)]
		btn.get_node("VBoxContainer/Solved").modulate = btn_colors[all_level_btns.find(btn)]
	else:
		btn.get_node("VBoxContainer/Label").modulate = Global.color_gui_gray
	
	
func _on_btn_pressed(btn):
	var pressed_btn_index: int = btn_grid_container.get_children().find(btn)
	play_selected_level(pressed_btn_index + 1)


func play_selected_level(selected_level: int):
	
	# set sweeper level
	Profiles.game_data_sweeper["level"] = selected_level
	# set sweeper game data
	Profiles.set_game_data(Profiles.Games.SWEEPER)
	Global.sound_manager.play_gui_sfx("menu_fade")
	animation_player.play("play_level")
	
			
func _on_BackBtn_pressed() -> void:
	
	Global.sound_manager.play_gui_sfx("screen_slide")
	animation_player.play_backwards("select_level")


func _on_SolutionsBtn_toggled(button_pressed: bool) -> void:
	
	if button_pressed:
		 Profiles.solution_hint_on = true
	else:
		 Profiles.solution_hint_on = false
		

# btn background tilemaps
	
#func set_btn_tilemap(btn: Button):
#
#		var BtnTilemap: PackedScene
#		var tilemap_position_adapt: float
#		match btn.name:
#			"01":
#				BtnTilemap = preload("res://game/tilemaps/sweeper/tilemap_sweeper_01.tscn")
#				tilemap_position_adapt = 0
#			"02":
#				BtnTilemap =  preload("res://game/tilemaps/sweeper/tilemap_sweeper_02.tscn")
#				tilemap_position_adapt = 0
#			"03":
#				BtnTilemap =  preload("res://game/tilemaps/sweeper/tilemap_sweeper_03.tscn")
#				tilemap_position_adapt = 0
#			"04":
#				BtnTilemap =  preload("res://game/tilemaps/sweeper/tilemap_sweeper_04.tscn")
#				tilemap_position_adapt = 2
#			"05":
#				BtnTilemap =  preload("res://game/tilemaps/sweeper/tilemap_sweeper_05.tscn")
#				tilemap_position_adapt = 2
#			"06":
#				BtnTilemap =  preload("res://game/tilemaps/sweeper/tilemap_sweeper_06.tscn")
#				tilemap_position_adapt = 2
#			"07":
#				BtnTilemap =  preload("res://game/tilemaps/sweeper/tilemap_sweeper_07.tscn")
#				tilemap_position_adapt = 2
#			"08":
#				BtnTilemap =  preload("res://game/tilemaps/sweeper/tilemap_sweeper_08.tscn")
#				tilemap_position_adapt = 2
#			"09":
#				BtnTilemap =  preload("res://game/tilemaps/sweeper/tilemap_sweeper_09.tscn")
#				tilemap_position_adapt = 2
#
#		var tilemap_scale_div: float = 8
#		var cell_size_x: float = 32
#
#		var new_btn_tilemap = BtnTilemap.instance()
#		new_btn_tilemap.scale /=  tilemap_scale_div
#		new_btn_tilemap.show_behind_parent = true
##		new_btn_tilemap.z_index = -1
#		btn.add_child(new_btn_tilemap)
#
#		var tilemap_reduced_size: Vector2 = new_btn_tilemap.get_used_rect().size * cell_size_x/2 / tilemap_scale_div
#		# sredinska pozicija
#		new_btn_tilemap.position.x = btn.rect_size.x/2 - tilemap_reduced_size.x# - btn.rect_size.x
#		new_btn_tilemap.position.y = btn.rect_size.y/2 - tilemap_reduced_size.y
#		# daptacija zamika pixilov
#		new_btn_tilemap.position.x += tilemap_position_adapt
#		new_btn_tilemap.position.y += tilemap_position_adapt
#		# barvanje 
#		new_btn_tilemap.get_tileset().tile_set_modulate(new_btn_tilemap.edge_tile_id, Color(1,1,1,0))
#		new_btn_tilemap.get_tileset().tile_set_modulate(new_btn_tilemap.edge_tile_id, Color.red)
#		new_btn_tilemap.get_tileset().tile_set_modulate(new_btn_tilemap.floor_tile_id, Color(1,1,1,0))
#		new_btn_tilemap.get_tileset().tile_set_modulate(new_btn_tilemap.spawn_stray_tile_id, Color.white) # prava barva se seta v select levels, v igri se jo itak zamenja s tlemi
#
#		new_btn_tilemap.set_process_input(false)
#
