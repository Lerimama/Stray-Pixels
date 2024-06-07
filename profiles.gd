extends Node


var default_player_stats: Dictionary = {
	"player_name" : "Somebody", # to ime se piše v HS procesu, če igralec pusti prazno
	"player_life" : 0, # se opredeli iz game_settings
	"player_energy" : 0, # se opredeli iz game_settings
	"player_points": 0,
	"colors_collected": 0,
	"skill_count" : 0,
	"burst_count" : 0,
	"cells_traveled" : 0,
}

var default_game_settings: Dictionary = {
	# player
	"player_start_life": 3, # 1 lajf skrije ikone v hudu, on hit jemlje energijo ne lajfa
	"player_start_color": Global.color_dark_gray_pixel, # na začetku je bel, potem se animira v start color ... #232323, #141414
	"step_time": 0.09, # default hitrost
	"player_start_energy": 192,
	# points
	"color_picked_points": 10, 
	"white_eliminated_points": 100, 
	"cleaned_reward_points": 1000,
	# energija
	"color_picked_energy": 10,
	"cell_traveled_energy": -1,
	"on_hit_wall_energy_part": 0.5,
	# reburst
	"reburst_enabled": false,
	"reburst_window_time": 0.3, # 0 je neomejen čas
	"reburst_hit_power": 0, # 0 gre po original pravilih moči, trenutno je 5 full power
	# strays
	"create_strays_count": 0,
	"spawn_white_stray_part": 0, # procenti spawnanih ... 0 ne spawna nobenega belega
	"spawn_white_stray_part_limit": 0.5, # klempam, da ni "brezveznih" situacij
	"respawn_strays_count_range": [0,0], # če je > 0, je respawn aktiviran
	"respawn_pause_time": 1, # če je 0 lahko pride do errorja (se mi zdi, da n 0, se timer sam disejbla)
	# game
	"game_time_limit": 0, # če je nič, ni omejeno in timer je stopwatch mode
	"game_music_track_index": 0, # default muska v igri
	"color_pool_colors_count": 500,
	"step_slowdown_mode": true,
	"full_power_mode": false, # vedno destroja ves stack, hitrost = max_cock_count
	"spawn_strays_on_cleaned": false,
	# gui
	"show_game_instructions": true,
	"position_indicators_show_limit": 6, # en manj je število vidnih
	"start_countdown": true,
	"zoom_to_level_size": false,
	# neu
	"respawn_pause_time_limit": 1, # klempam na tole
}

enum Games {
	CLASSIC,
	CLEANER_S, CLEANER_M, CLEANER_L,
	ERASER,
	DEFENDER,
	SWEEPER,
	THE_DUEL,
	SHOWCASE,
	}
	
	
enum HighscoreTypes {
	NO_HS, 
	HS_POINTS, 
	HS_COLORS, 
	HS_TIME_LOW, 
	HS_TIME_HIGH
	}

	
var game_data_classic: Dictionary = { 
	"game": Games.CLASSIC,
	"highscore_type": HighscoreTypes.HS_POINTS,
	"game_name": "Classic",
	"game_scene_path": "res://game/game.tscn",
	"tilemap_path": "res://game/tilemaps/tilemap_classic.tscn",
	"description" : "Team up for a cleaning frenzy!",
	"Prop" : "Clear all stray pixels\nto reclaim your\none-and-only status.",
	"Prop2" : "Give it your best shot\nto beat the current\nrecord score!",
}
var game_data_cleaner_s: Dictionary = { 
	"game": Games.CLEANER_S,
	"highscore_type": HighscoreTypes.HS_TIME_LOW,
	"game_name": "Cleaner S",
	"game_scene_path": "res://game/game.tscn",
	"tilemap_path": "res://game/tilemaps/tilemap_cleaner_s.tscn",
	"description" : "Clear the colors before time slips away!",
	"Prop" : "You have %s minutes\nbefore your screen becomes\npermanently saturated." % str(2), # CON ročno povezano z game time
	"Prop2" : "Be quick and efficient\nto beat the current\nrecord time!",
}
var game_data_cleaner_m: Dictionary = {
	"game": Games.CLEANER_M,
	"highscore_type": HighscoreTypes.HS_TIME_LOW,
	"game_name": "Cleaner M",
	"game_scene_path": "res://game/game.tscn",
	"tilemap_path": "res://game/tilemaps/tilemap_cleaner_m.tscn",
	"description" : "Race the clock and clean up the color explosion!",
	"Prop" : "You have %s minutes\nbefore your screen becomes\npermanently saturated." % str(5), # CON ročno povezano z game time
	"Prop2" : "Be quick and efficient\nto beat the current\nrecord time!",
}
var game_data_cleaner_l: Dictionary = {
	"game": Games.CLEANER_L,
	"highscore_type": HighscoreTypes.HS_TIME_LOW,
	"game_name": "Cleaner L",
	"game_scene_path": "res://game/game.tscn",
	"tilemap_path": "res://game/tilemaps/tilemap_cleaner_l.tscn",
	"description" : "Clean up this colored mess before the clock runs out!",
	"Prop" : "You have %s minutes\nbefore your screen becomes\npermanently saturated." % str(10), # CON ročno povezano z game time
	"Prop2" : "Be quick and efficient\nto beat the current\nrecord time!",
}
var game_data_eraser: Dictionary = { 
	"game": Games.ERASER,
	"highscore_type": HighscoreTypes.HS_POINTS,
	"game_name": "Eraser",
	"game_scene_path": "res://game/game.tscn",
	"tilemap_path": "res://game/tilemaps/tilemap_eraser.tscn",
	"description" : "Keep the colors in check as they keep popping in!",
	"Prop": "Difficulty level will increase\nwhen your spectrum\nindicator gets filled.",
	"Prop2" : "Give it your best shot\nto beat the current\nrecord score!",
	# štart
	"level": 1,
	"level_goal_count": 10, # # CON level_goal_mode ... ročno povezano s številom spawnanih na tilemapu
	"level_goal_count_grow": 3,
	# "create_strays_count": 0, # določi tilemap
	"create_strays_count_grow": 0,
	# "respawn_strays_count_range": [2,8],
	"respawn_strays_count_range_grow": [1,1],
	# "respawn_pause_time": 3,
	"respawn_pause_time_factor": 0.80,
	# "spawn_white_stray_part": 0.21,
	"spawn_white_stray_part_grow": 0, # omejena na 2. level na set_new_level
}
var game_data_defender: Dictionary = { 
	"game": Games.DEFENDER,
	"highscore_type": HighscoreTypes.HS_POINTS,
	"game_name": "Defender",
	"game_scene_path": "res://game/game_defender.tscn",
	"tilemap_path": "res://game/tilemaps/tilemap_defender.tscn",
	"description" : "Defend your screen against invading colors!",
	"Prop" : "Player is always\nfull of energy,\nbut has no skills.",
	"Prop2": "Difficulty level will\nincrease when your\nspectrum indicator\ngets filled.",
	"Prop3" : "Give it your\nbest shot to\nbeat the current\nrecord score!",
	# štart
	"level": 1,
	"level_goal_count": 10, # CON kolikor jih spawnanih v prvi rundi
	"line_step_pause_time": 1.5, # ne sme bit manjša od stray step hitrosti (0.2), je clampana ob apliciranju
	"spawn_round_range": [1, 1], # random spawn count, največ 120 - 8
	"line_steps_per_spawn_round": 1, # na koliko stepov se spawna nova runda
	# level up
	"level_goal_count_grow": 320, # dodatno prištejem
	"line_step_pause_time_factor": 0.8, # množim z vsakim levelom
	"spawn_round_range_grow": [1, 1], # množim [spodnjo, zgornjo] mejo
	"line_steps_per_spawn_round_factor": 3, # na koliko stepov se spawna nova runda
}
var game_data_the_duel: Dictionary = {
	"game": Games.THE_DUEL,
	"highscore_type": HighscoreTypes.NO_HS,
	"game_name": "The Duel",
	"game_scene_path": "res://game/game.tscn",
	# "tilemap_path": "res://game/tilemaps/tilemap_duel.tscn",
	"tilemap_path": "res://game/tilemaps/tilemap_duel_lite.tscn",
	"description" : "Only the best cleaner will shine in this epic battle!",
	"Prop": "Player with better\nfinal score will be named\nthe Ultimate cleaning champ!",
	"Prop2": "Hit the opposing player\nto take his life and\nhalf of his points.",
}
var game_data_sweeper: Dictionary = {
	"game": Games.SWEEPER,
	"highscore_type": HighscoreTypes.HS_TIME_LOW,
	"game_name": "Sweeper",
	"game_scene_path": "res://game/game.tscn",
	"tilemap_path": "res://game/tilemaps/sweeper/tilemap_sweeper_01.tscn",
	"description" : "Sweep the entire screen in one spectacular move!",
	"Prop" : "Hit the first\nstray pixel and keep rebursting till there\nare none left.",
	"Prop2" : "To reburst when hitting a pixel, press\nin a direction of\nthe next target.",
	"Prop3" : "Showcase your\nmastery and beat\nthe record time!",
	"level": 3,
}
var game_data_showcase: Dictionary = {
	"game": Games.SHOWCASE,
	"highscore_type": HighscoreTypes.HS_POINTS,
	"game_name": "Showcase",
#	"game_scene_path": "res://game/game_showcase.tscn",
#	"tilemap_path": "res://game/tilemaps/testing/tilemap_testing.tscn",
#	"tilemap_path": "res://game/tilemaps/testing/tilemap_testing_2.tscn",
#	"tilemap_path": "res://game/tilemaps/testing/tilemap_testing_3.tscn",
#	"tilemap_path": "res://game/tilemaps/testing/tilemap_testing_4.tscn",
#	"tilemap_path": "res://game/tilemaps/testing/tilemap_testing_5.tscn",
}


# ON GAME START -----------------------------------------------------------------------------------

var sweeper_tilemaps_folder: String = "res://game/tilemaps/sweeper/"
var sweeper_level_tilemap_paths: Array
var game_settings: Dictionary# = default_game_settings # = {}
var current_game_data: Dictionary # ob štartu igre se vrednosti injicirajo v "current_game_data"
var use_default_color_theme: bool = true

var get_it_time: float = 1 # tajming za dojet določene faze igre

# nastavitve, ki se setajo tudi v home
var solution_hint_on: bool = false
var camera_shake_on: bool = true
var tutorial_music_track_index: int = 1
var tutorial_mode



func _ready() -> void:
	
	sweeper_level_tilemap_paths = Global.get_folder_contents(sweeper_tilemaps_folder)

	# če greš iz menija je tole povoženo
#	var debug_game = Games.SHOWCASE
#	var debug_game = Games.CLASSIC
#	var debug_game = Games.CLEANER_S
#	var debug_game = Games.CLEANER_M
#	var debug_game = Games.CLEANER_L
#	var debug_game = Games.ERASER
#	var debug_game = Games.DEFENDER
	var debug_game = Games.SWEEPER
#	var debug_game = Games.THE_DUEL
	set_game_data(debug_game)
	
	
func set_game_data(selected_game) -> void:
	
	game_settings = default_game_settings.duplicate() # naloži default, potrebne spremeni ob loadanju igre
	
#	# debug
	game_settings["start_countdown"] = false
#	game_settings["player_start_life"] = 2
#	game_settings["show_game_instructions"] = false
		
	match selected_game:

		Games.SHOWCASE: 
			current_game_data = game_data_showcase.duplicate()
			game_settings["player_start_color"] = Color.white
			game_settings["reburst_hit_power"] = 1
			game_settings["reburst_enabled"] = true			
			game_settings["reburst_window_time"] = 0
			game_settings["create_strays_count"] = 50
		
		Games.CLASSIC: 
			current_game_data = game_data_classic.duplicate()
			game_settings["create_strays_count"] = 500
			game_settings["game_time_limit"] = 0
			game_settings["start_countdown"] = false
			game_settings["game_music_track_index"] = 1
			
		Games.CLEANER_S: 
			current_game_data = game_data_cleaner_s.duplicate()
			game_settings["game_time_limit"] = 10
			game_settings["create_strays_count"] = 50 # ravno prav da se jih da uničit
			game_settings["spawn_white_stray_part"] = 0.11 # 10 posto
		Games.CLEANER_M: 
			current_game_data = game_data_cleaner_m.duplicate()
			game_settings["game_time_limit"] = 300
			game_settings["create_strays_count"] = 140 # ravno prav da se jih da uničit
			game_settings["spawn_white_stray_part"] = 0.11
		Games.CLEANER_L: 
			current_game_data = game_data_cleaner_l.duplicate()
			game_settings["game_time_limit"] = 600
			game_settings["create_strays_count"] = 320 # ravno prav da se jih da uničit
			game_settings["spawn_white_stray_part"] = 0.11
		
		Games.ERASER: 
			current_game_data = game_data_eraser.duplicate()
			game_settings["start_countdown"] = false
			game_settings["position_indicators_show_limit"] = 0
			#
			game_settings["respawn_strays_count_range"] = [2, 8]
			game_settings["respawn_pause_time"] = 3
			game_settings["spawn_white_stray_part"] = 0.32
		
		Games.DEFENDER:
			current_game_data = game_data_defender.duplicate()
			game_settings["cell_traveled_energy"] = 0
			game_settings["position_indicators_show_limit"] = 0
			game_settings["full_power_mode"] = true
			game_settings["start_countdown"] = false
			game_settings["game_music_track_index"] = 1
			#
			game_settings["create_strays_count"] = 1 # število spawnanih v prvi rundi
		
		Games.THE_DUEL: 
			current_game_data = game_data_the_duel.duplicate()
			game_settings["game_time_limit"] = 180 # tilemap set
			game_settings["spawn_strays_on_cleaned"] = true
			game_settings["zoom_to_level_size"] = true
			game_settings["position_indicators_show_limit"] = 0
		
		Games.SWEEPER: 
			current_game_data = game_data_sweeper.duplicate()
			game_settings["player_start_life"] = 1
			game_settings["on_hit_wall_energy_part"] = 1
			game_settings["color_picked_points"] = 0
			game_settings["cell_traveled_energy"] = 0
			game_settings["cleaned_reward_points"] = 1 # ... izpiše se "SUCCESS!" # TEST
			game_settings["position_indicators_show_limit"] = 0
			game_settings["zoom_to_level_size"] = true
			game_settings["reburst_enabled"] = true
			game_settings["reburst_window_time"] = 0	
			game_settings["game_music_track_index"] = 1
