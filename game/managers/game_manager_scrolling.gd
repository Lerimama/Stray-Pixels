#extends GameManager # default game manager
extends GameManager # default game manager

var current_stray_spawning_round: int = 0 # prištevam na koncu spawna

var lines_scrolled_count: int = 0 # prištevam v stray_step()
var lines_scroll_per_spawn_round: int #  = 1 # se vleče game data
var scrolling_pause_time: float # pavza med stepi
var total_spawn_round_positions_count: int = 20 # določeno v tilemapu ... 20 x na linijo
var round_spawn_possibility: float
var stray_to_spawn_round_range: Array

var current_stage: int = 0 # na štartu se kliče stage up
var stages_per_level: int
var current_level: int = 0 # na štartu se kliče level up
var levels_per_game: int = 1
var all_stage_level_colors_available: Array
var stray_spawn_colors_available: Array # samo za spawnanje, ne pa za spektrum
var default_stray_spawn_colors_count: int = 500 # na začetkiu ... ob spawnu se odštevajo, ko jih ni več, se resetira na to vrednost

var in_level_transition: bool = false
var step_in_progress: bool = false
var wall_spawn_random_range: int
var wall_strays_on_edge_count: int = 0 # ko, je ves edge zaseden, je konec

# nikoli ne restiram
var wall_strays: Array = [] # vsi straysi,ki so celotna tla
var first_wall_round: bool = true

# resetiram na floor filled
var wall_edge_strays: Array = [] # straysi ki predstavljajo rob tal
var strays_on_wall_edge: Array = [] # strays, ki se dotikajo robnih tiletov tal ... se resetira na vsako polnitev
var all_strays_on_wall: Array = [] # vsi strays, ki so ustavljeni ker so spodaj tla

# resetira se na vsak korak
var connected_strays_on_wall_edge: Array = [] # straysi na robu tal, ki so povezani
var strays_on_wall_edge_connected: bool = false
var available_home_spawn_positions: Array


func _unhandled_input(event: InputEvent) -> void:

	if Input.is_action_just_pressed("l"):
		upgrade_level()	
	if Input.is_action_just_pressed("n"):
		stop_stray_spawning()

			
func _ready() -> void:

	Global.game_manager = self
	StrayPixel = preload("res://game/pixel/stray_scrolling.tscn")
	PlayerPixel = preload("res://game/pixel/player_scrolling.tscn")
	randomize()
	
	
func _process(delta: float) -> void:
	# namen: kličem stray step, čekiram zasedenost home spawn pozicij in kličem GO
	# namen: ni preverjanja avail respawn pozicij in GO
	
	if game_on:
		# vsakič znova zajamemo vse in ji potem odštejemo trenutno zasedene
		available_home_spawn_positions = random_spawn_positions.duplicate()
		for stray in get_tree().get_nodes_in_group(Global.group_strays):
			var stray_grid_position: Vector2 = stray.global_position - Vector2(cell_size_x/2, cell_size_x/2)
			if available_home_spawn_positions.has(stray_grid_position):
				available_home_spawn_positions.erase(stray_grid_position)
		if available_home_spawn_positions.empty(): # če je pogoj "polno" izpolnjen, je itak izpolnjen tudi ta pogoj
			game_over(GameoverReason.TIME)	
		if not step_in_progress:
			stray_step()

		
func set_game(): 
	# namen: setam level indikatorje in strayse spawnam po štratu igre
	
	# player intro animacija
	var signaling_player: KinematicBody2D
	for player in get_tree().get_nodes_in_group(Global.group_players):
		player.animation_player.play("lose_white_on_start")
#		player.animation_player.play_backwards("lose_white_on_start")
		signaling_player = player # da se zgodi na obeh plejerjih istočasno
	yield(signaling_player, "player_pixel_set") # javi player na koncu intro animacije
	
	yield(get_tree().create_timer(1), "timeout") # da si plejer ogleda

	Global.hud.slide_in(start_players_count)
	yield(Global.start_countdown, "countdown_finished") # sproži ga hud po slide-inu

	start_game()
	

func start_game():

	Global.hud.game_timer.start_timer()
	Global.sound_manager.play_music("game_music")

	for player in get_tree().get_nodes_in_group(Global.group_players):
		player.set_physics_process(true)
	
	yield(get_tree().create_timer(2), "timeout") # čaka na hudov slide in
	game_on = true
	
	upgrade_level()
	
	spawn_strays(start_strays_spawn_count)

	# stray_step() # prvi step ... ne rabim, ker kliče že GM


func game_over(gameover_reason: int):
	# namen: CLEANED ni GO, ampak upgrade
	
	if game_on == false: # preprečim double gameover
		return
	game_on = false
	
	Global.hud.game_timer.stop_timer()
	
	get_tree().call_group(Global.group_players, "set_physics_process", false)

	yield(get_tree().create_timer(1), "timeout") # za dojet

	stop_game_elements()

	Global.gameover_menu.open_gameover(gameover_reason)
		
		
# SETUP --------------------------------------------------------------------------------------


func set_tilemap():
	# namem: dodam povezavo s signalom  iz aree	
	
	var tilemap_to_release: TileMap = Global.current_tilemap # trenutno naložen v areni
	var tilemap_to_load_path: String = game_data["tilemap_path"]
	
	# release default tilemap	
	tilemap_to_release.set_physics_process(false)
	tilemap_to_release.free()
	
	# spawn new tilemap
	var GameTilemap = ResourceLoader.load(tilemap_to_load_path)
	var new_tilemap = GameTilemap.instance()
	Global.node_creation_parent.add_child(new_tilemap) # direct child of root
	
	# povežem s signalom	
	Global.current_tilemap.connect("tilemap_completed", self, "_on_tilemap_completed")
	
	# grab tilemap tiles
	Global.current_tilemap.get_tiles()
	cell_size_x = Global.current_tilemap.cell_size.x 


func set_game_view():
	
	#namen: ... tudi fiksirana kamera
	
	# viewports
	var viewport_1: Viewport = $"%Viewport1"
	var viewport_2: Viewport = $"%Viewport2"
	var viewport_container_2: ViewportContainer = $"%ViewportContainer2"
	var viewport_separator: VSeparator = $"%ViewportSeparator"

	var cell_align_start: Vector2 = Vector2(cell_size_x, cell_size_x/2)
	# Global.player1_camera.position = player_start_positions[0] + cell_align_start

	viewport_container_2.visible = false
	viewport_separator.visible = false

	# set player camera limits
	var tilemap_edge = Global.current_tilemap.get_used_rect()
	# Global.player1_camera.set_camera_limits()

	
func set_players():
	# namen: podajanje dobljenih točk v GM
	
	for player_position in player_start_positions: # glavni parameter, ki opredeli število igralcev
		spawned_player_index += 1 # torej začnem z 1
		
		# spawn
		var new_player_pixel: KinematicBody2D
		new_player_pixel = PlayerPixel.instance()
		new_player_pixel.name = "p%s" % str(spawned_player_index)
		new_player_pixel.global_position = player_position + Vector2(cell_size_x/2, cell_size_x/2) # ... ne rabim snepat ker se v pixlu na ready funkciji
#		new_player_pixel.modulate = game_settings["player_start_color"]
		new_player_pixel.z_index = 1 # nižje od straysa
		Global.node_creation_parent.add_child(new_player_pixel)
		
		# stats
		new_player_pixel.player_stats = Profiles.default_player_stats.duplicate() # tukaj se postavijo prazne vrednosti, ki se nafilajo kasneje
		new_player_pixel.player_stats["player_energy"] = game_settings["player_start_energy"]
		new_player_pixel.player_stats["player_life"] = game_settings["player_start_life"]
		
		# povežem s hudom
		new_player_pixel.connect("stat_changed", Global.hud, "_on_stat_changed")
		new_player_pixel.emit_signal("stat_changed", new_player_pixel, new_player_pixel.player_stats) # štartno statistiko tako javim 
		
		# pregame setup
		new_player_pixel.set_physics_process(false)
		
		# players camera
		if spawned_player_index == 1:
			new_player_pixel.player_camera = Global.player1_camera
			Global.player1_camera.position = new_player_pixel.global_position + Vector2(cell_size_x/2, - cell_size_x/2)
		elif spawned_player_index == 2:
			new_player_pixel.player_camera = Global.player2_camera
		

# STRAYS -----------------------------------------------------------------------------


func spawn_strays(strays_to_spawn_count: int):
	# namen: no clampin, ker je lahko spawn 0
	# namen: v žrebanje vključim samo home spawn pozicije na voljo
	# namen: ni preverjanja vseh drugih mogočih pozicij
	
	for stray_index in strays_to_spawn_count:
		
		# spawn barve na voljo
		if current_level <= 1: # na začetku je pisana tema
			if stray_spawn_colors_available.empty(): # če je prazna se restira
				stray_spawn_colors_available = Global.get_spectrum_colors(default_stray_spawn_colors_count)
			else:
				stray_spawn_colors_available = Global.get_spectrum_colors(stray_spawn_colors_available.size())
		else:
			if stray_spawn_colors_available.empty():
				stray_spawn_colors_available = Global.get_random_gradient_colors(default_stray_spawn_colors_count)
			else:
				stray_spawn_colors_available = Global.get_random_gradient_colors(stray_spawn_colors_available.size())
		
		# žrebam barvo
		var random_color_range = stray_spawn_colors_available.size()
		var random_selected_index: int = randi() % int(random_color_range) # + 1		
		var random_selected_color: Color = stray_spawn_colors_available[random_selected_index]		
		
		if not available_home_spawn_positions.empty():
			# možne spawn pozicije
			var current_spawn_positions: Array = available_home_spawn_positions
			# random pozicija med možnimi
			var random_range = current_spawn_positions.size()
			var selected_cell_index: int = randi() % int(random_range)# + 1		
			var selected_position = current_spawn_positions[selected_cell_index]
			# spawn stray
			var new_stray_pixel = StrayPixel.instance()
			new_stray_pixel.name = "S%s" % str(stray_index)
			new_stray_pixel.global_position = selected_position + Vector2(cell_size_x/2, cell_size_x/2) # dodana adaptacija zaradi središča pixla
			new_stray_pixel.z_index = 2 # višje od plejerja
			new_stray_pixel.stray_color = random_selected_color
			Global.node_creation_parent.add_child(new_stray_pixel)
			new_stray_pixel.show_stray()
			
			# odstranim uporabljeno pozicije in barve dodam v števec
			stray_spawn_colors_available.erase(random_selected_color)
			available_home_spawn_positions.erase(selected_position)
			self.strays_in_game_count = 1 # setget sprememba
			
	current_stray_spawning_round += 1


func stray_step():
	
	# if get_tree().paused:
	#	return

	step_in_progress = true
		
	var stepping_direction: Vector2
	
	# random spawn count
	var random_spawn_count: int = randi() % stray_to_spawn_round_range[1] + stray_to_spawn_round_range[0]
	if random_spawn_count > stray_to_spawn_round_range[1]: 
		random_spawn_count -= random_spawn_count - stray_to_spawn_round_range[1] # odštejem kar je višje od maximuma, ker zamik zamakne tudi zgornjo mejo
	
	if not in_level_transition: # and not strays_on_wall_edge_connected:
		stepping_direction = Vector2.DOWN
		# kdo stepa, kličem step in preverim kolajderja 
		for stray in get_tree().get_nodes_in_group(Global.group_strays):
			if not wall_strays.has(stray) and not all_strays_on_wall.has(stray): # če stray ni del stene in ni naložen na steni
				var current_collider = stray.step(stepping_direction)
				if current_collider:
					check_stray_wall_collisions(stray, current_collider) # brez povezanosti na robu
		# Global.sound_manager.play_sfx("stray_step") # ulomek je za pitch zvoka
		lines_scrolled_count += 1
		if lines_scrolled_count % lines_scroll_per_spawn_round == 0: # tukaj, da ne spawna če je konec
			print(current_stray_spawning_round)
			if current_stray_spawning_round == 1: 
				spawn_strays(random_spawn_count)
			else: #if lines_scrolled_count > 10:
				# spawnam, če je znotraj določenih procentov
				if randi() % 100 <= round_spawn_possibility:
					spawn_strays(random_spawn_count)
			
	yield(get_tree().create_timer(scrolling_pause_time), "timeout")
	
	step_in_progress = false

		
func play_stepping_sound(current_player_energy_part: float):

	if Global.sound_manager.game_sfx_set_to_off:
		return		

	var random_step_index = randi() % $Sounds/Stepping.get_child_count()
	var selected_step_sound = $Sounds/Stepping.get_child(random_step_index)
	selected_step_sound.pitch_scale = clamp(current_player_energy_part, 0.6, 1)
	selected_step_sound.play()
	
		
# LEVELING --------------------------------------------------------------------------------------


func upgrade_stage():
	# kliče stray na die
	
	# stage up na vsak klic ... tudi ob apgrejdanju level
	current_stage += 1
	Global.hud.update_indicator_on_stage_up(current_stage) # povdari indikator
	
	# če je dosežen level se izvede tudi upgrade levela (ima pavzo)
	if current_stage > stages_per_level:
		upgrade_level()


func upgrade_level():
	
	current_level += 1 # številka novega levela 
	
	in_level_transition = true
		
	# pogoji novega levela
	set_new_level() 
	# spraznem in indkatorje
	Global.hud.empty_color_indicators() # novi indkatorji
	# naštimam nove barve
	set_level_colors()
	
	# razen level 1
	if not current_level == 1:
		
		current_stage = 1 # ker se šteje pobite strayse je na začetku 0
		Global.hud.level_up_popup_in(current_level)
		Global.hud.update_indicator_on_stage_up(current_stage) # obarvaj prvega
		
		# pavza pri prehoud lavela .... za pedenanjem indikatorjev in pucanje ekrana
		get_tree().call_group(Global.group_players, "set_physics_process", false)
		clean_strays_in_game() #puca vse v igri
		yield(self, "all_strays_died") # ko so vsi iz igre grem naprej
		
		Global.hud.level_up_popup_out()
		get_tree().call_group(Global.group_players, "set_physics_process", true)
	else:
		current_stage = 0 # ker se šteje pobite strayse je na začetku 0
	
	in_level_transition = false		


func set_new_level():
	
	# prvi level vzame že zapisane		
	if current_level == 1:
		lines_scroll_per_spawn_round = game_data["lines_scroll_per_spawn_round"]
		stages_per_level = game_data["stages_per_level"]
		scrolling_pause_time = game_data["scrolling_pause_time"]
		stray_to_spawn_round_range = game_data["stray_to_spawn_round_range"]
		round_spawn_possibility = game_data["round_spawn_possibility"]
		
	# vsak naslednji level updata nastavitve prejšnjega levela
	elif current_level > 1:
		stages_per_level += stages_per_level + game_data["stages_per_level_grow"]
		scrolling_pause_time *= game_data["scrolling_pause_time_factor"]
		scrolling_pause_time = clamp (scrolling_pause_time, 0.2, scrolling_pause_time) # ne sem bit manjša od stray step hitrosti (cca 0.2)
		stray_to_spawn_round_range[0] *= game_data["round_range_factor_1"]
		stray_to_spawn_round_range[1] *= game_data["round_range_factor_2"]
		round_spawn_possibility *= game_data["round_spawn_possibility_factor"]
	
	game_data["level"] = current_level


func set_level_colors():
	
	all_stage_level_colors_available = []
	if current_level <= 1: # na začetku je pisana tema
		all_stage_level_colors_available = Global.get_spectrum_colors(stages_per_level)
	else:
		all_stage_level_colors_available = Global.get_random_gradient_colors(stages_per_level)
		
	var selected_color_position_x: float
	var current_color: Color
	
	for stage in stages_per_level:
		if current_level <= 1: # na začetku je pisana tema
			current_color = all_stage_level_colors_available[stage]
		else:
			current_color = all_stage_level_colors_available[stage]

	Global.hud.spawn_color_indicators(all_stage_level_colors_available) # barve pokažem v hudu	
		

# UTILITI -------------------------------------------------------------------------------------------------------------------------------


func clean_strays_in_game():
	
	var all_strays_alive: Array = get_tree().get_nodes_in_group(Global.group_strays)
	
	# javim število, ki se bo pucalo ... to pomeni, da se tudi teli štejejo v spucane od plejjerja
	# self.strays_in_game_count = all_strays_alive.size() # setget sprememba
	
	for stray in all_strays_alive:
		# najprej setam STATIC ... tudi DYING postanejo static, da lahko kličem die()
		
		# tiste, ki so že tla spremenim v static ... ne pa tudi umrlih od trenutnega hita
		if wall_strays.has(stray):
			stray.current_state = stray.States.IDLE
#			stray.current_state = stray.States.STATIC
			wall_strays.erase(stray)
		# cela tla
		var stray_index: int = all_strays_alive.find(stray)
		var all_strays_alive_count: int = all_strays_alive.size()
		stray.die(stray_index, all_strays_alive_count)
	
	self.strays_in_game_count = all_strays_alive.size() # setget sprememba
	
	all_strays_died_alowed = true # javi signal, ko so vsi spucani 
	
	return true
	
	
func check_stray_wall_collisions(current_stray: KinematicBody2D, current_collider: Node): # preverjanje, ko ne iščeš polnosti tal
	
	# prva runda ... kolajder tilemap (tla)
	if current_collider.is_in_group(Global.group_tilemap):
		wall_strays.append(current_stray)
		current_stray.die_to_wall()
#		current_stray.turn_to_wall(1)
	# druge runde ... kolajder stray in je rob tal
	elif current_collider.is_in_group(Global.group_strays) and wall_strays.has(current_collider):
		wall_strays.append(current_stray)
		current_stray.die_to_wall()
#		current_stray.turn_to_wall(1)
			
			
func stop_stray_spawning():
	random_spawn_positions.clear()


func _change_strays_in_game_count(strays_count_change: int):
	# namen: brez CLEANED GO
	
	strays_in_game_count += strays_count_change # in_game št. upošteva spawnanje in čiščenje (+ in -)
	strays_in_game_count = clamp(0, strays_in_game_count, strays_in_game_count)
	
	if strays_count_change < 0: # cleaned št. upošteva samo čiščenje (+)
		strays_cleaned_count += abs(strays_count_change)
	
