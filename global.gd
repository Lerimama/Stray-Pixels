extends Node2D


# VARS ----------------------------------------------------------

var main_node = null
var node_creation_parent = null # arena

# managers
var sound_manager = null
var data_manager = null
var game_manager = null

# gui
var game_tilemap = null
var hud = null
var start_countdown = null
var gameover_menu = null
var tutorial_gui = null

# camera
var p1_camera = null
var p2_camera = null
var p1_camera_target = null
var p2_camera_target = null

# groups
var group_players = "Players"
var group_strays = "Strays"
var group_tilemap = "Tilemap"

# sivi klin
var color_white = Color("#ffffff")
var color_black_almost = Color("#141414")
var color_gray_dark = Color("#232323") # hud undi

# colors
var color_blue = Color("#4b9fff")
var color_green = Color("#5effa9")
var color_red = Color("#f35b7f")
var color_yellow = Color("#fef98b")


# METHODS ----------------------------------------------------------


var current_scene = null # scene switching


func _ready():
	randomize()


func reset_cameras():
	p1_camera = null
	p1_camera_target = null
	p2_camera = null	
	p2_camera_target = null
	

func snap_to_nearest_grid(current_global_position: Vector2, cell_positions):
	
	if not is_instance_valid(game_tilemap):
		print("ERROR! Snapanje na grid ... manjka Global.game_tilemap")
		return
		
	var floor_cells: Array = game_tilemap.floor_cells_global_positions
	var tilemap_cells: Array = game_tilemap.floor_cells_global_positions
	var cell_size_x: float = game_tilemap.cell_size.x  # pogreba od GMja, ki jo dobi od tilemapa
	
	# adaptacija zaradi središčne točke strejsa in playerja
	var current_position: Vector2 = Vector2(current_global_position.x - cell_size_x/2, current_global_position.y - cell_size_x/2)
	
	# če ni že snepano
	if not floor_cells.has(current_position): 
		# določimo distanco znotraj katere preverjamo bližino točke
		var distance_to_position: float = cell_size_x # začetna distanca je velikosti celice ... potem izbrana je itak bližja
		var nearest_cell: Vector2
		for cell in floor_cells:
			if cell.distance_to(current_position) < distance_to_position:
				distance_to_position = cell.distance_to(current_position)
				nearest_cell = cell
		# snap position
		var snap_to_position: Vector2 = Vector2(nearest_cell.x + cell_size_x/2, nearest_cell.y + cell_size_x/2)
		return snap_to_position
	else: 
		return current_global_position # vrneš isto pozicijo na katere že je 


func detect_collision_in_direction(ray, direction_to_check):
	
	if not is_instance_valid(game_tilemap):
		print("ERROR! Detect_collision ... manjka Global.game_tilemap")
		return
	
	var cell_size_x: int = game_tilemap.cell_size.x  # pogreba od GMja, ki jo dobi od tilemapa
	
	ray.cast_to = direction_to_check * cell_size_x # ray kaže na naslednjo pozicijo 
	ray.force_raycast_update()	
	
	if ray.is_colliding():
		var ray_collider = ray.get_collider()
		return ray_collider
	
		
func get_random_member_index(group_of_elements, offset): # offset je če zamakneš začetek
		# uporabljam pri: ... nikjer

		var random_range = group_of_elements.size()
		var selected_int = randi() % int(random_range) + offset
#		var selected_value = current_array[random_int]

		printt("RANDOM", random_range, selected_int)
		return selected_int


# SCENE MANAGER (prehajanje med igro in menijem) ----------------------------------------------------------------


func release_scene(scene_node): # release scene
	scene_node.set_physics_process(false)
	call_deferred("_free_scene", scene_node)	


func _free_scene(scene_node):
	print ("SCENE RELEASED (in next step): ", scene_node)	
	scene_node.free()
	

func spawn_new_scene(scene_path, parent_node): # spawn scene

	var scene_resource = ResourceLoader.load(scene_path)
	
	current_scene = scene_resource.instance()
	print ("SCENE INSTANCED: ", current_scene)
	
	current_scene.modulate.a = 0
	parent_node.add_child(current_scene) # direct child of root
	print ("SCENE ADDED: ", current_scene)	
	
	return current_scene
