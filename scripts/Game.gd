extends Node


onready var arena: Node2D = $Viewports/ViewportContainer1/Viewport1/Arena
onready var viewport_1: Viewport = $Viewports/ViewportContainer1/Viewport1
onready var P1_camera: Camera2D = $Viewports/ViewportContainer1/Viewport1/Camera2D
onready var minimap_camera: Camera2D = $Viewports/ViewportContainer1/Viewport1/Camera2D
onready var minimap_viewport: Viewport = $Minimap/MinimapViewport


func _ready() -> void:
	
	minimap_viewport.world_2d = viewport_1.world_2d
	
	# to je za nespawnanega ... spawnan se seta iz GMa
	# camera global node se seta ob spawnanjeu plejerja
	
	set_camera_limits()
	
	
func set_camera_limits():
	
	var tilemap_edge = Global.level_tilemap.get_used_rect()	
	var tilemap_cell_size = Global.level_tilemap.cell_size
	
	for camera in [minimap_camera, P1_camera]:
		camera.limit_left = tilemap_edge.position.x * tilemap_cell_size.x # 0,0
		camera.limit_right = tilemap_edge.end.x * tilemap_cell_size.x # 0,0
		camera.limit_top = tilemap_edge.position.y * tilemap_cell_size.y # 0,0
		camera.limit_bottom = tilemap_edge.end.y * tilemap_cell_size.y # 0,0

