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


var default_game_settings: Dictionary = { # to so default CLEANING settings
	# player
	"player_start_life": 1, # 1 lajf skrije ikone v hudu in določi "lose_life_on_hit"
	"player_start_energy": 192, # če je 0, je 0 ... instant GO
	"player_start_color": Color("#232323"), # old #141414
	"player_max_energy": 192, # max energija
	"player_tired_energy": 20, # pokaže steps warning popup in hud oabrva rdeče
	"step_time_fast": 0.09, # default hitrost
	"step_time_slow": 0.15, # minimalna hitrost
	"step_slowdown_rate": 18, # delež energije, manjši pada hitreje
	# scoring
	"all_cleaned_points": 1000,
	"color_picked_points": 10, 
	"cell_traveled_points": 0,
	"skill_used_points": 0,
	"burst_released_points": 0,
	"on_hit_points_part": 2,
	# energija
	"color_picked_energy": 10,
	"cell_traveled_energy": -1,
	"skill_used_energy": 0,
	"burst_released_energy": 0,
	"on_hit_energy_part": 2, # delež porabe od trenutne energije
	"touching_stray_energy": 0,
	# reburst
	"reburst_count_limit": 0, # 0 je unlimited
	"reburst_reward_limit": 0, # 0 je brez nagrade
	"reburst_reward_points": 100, # kolk jih destroya ... 0 gre po original pravilih moči
	"reburst_window_time": 0.2, # 0 je neomejen čas
	"reburst_hit_power": 1, # kolk jih destroya ... 0 gre po original pravilih moči, 5 je full power
	# game
	"reburst_mode": true,
	"timer_mode_countdown" : true, # če prišteva in je "game_time_limit" = 0, nima omejitve navzgor
	"lose_life_on_hit": false, # zadetek od igralca ali v steno pomeni izgubo življenja, alternativa je izguba energije
	"step_slowdown_mode": true,
	"eternal_mode": false,
	"turn_stray_to_wall": true, # eternal big screen
	"full_power_mode": false, # hitrost je tudi max_cock_coiunt > vedno destroja ves bulk 
	# gui
	"gameover_countdown_duration": 5,
	"show_position_indicators_stray_count": 5,
	"position_indicators_on": true, # duel jih nima 
	"spectrum_start_on": false, # a pobrane prižigam al ugašam
	"zoom_animation": true,
	"start_countdown": false,
	"game_instructions_popup": true,
	"solutions_mode": false # enigma reštve
}


enum Games {
	TUTORIAL,
	ERASER_S, ERASER_M, ERASER_L,
	CLEANER, CLEANER_DUEL,
	ETERNAL, ETERNAL_XL,
	ENIGMA,
	SCROLLER,
	}
enum HighscoreTypes {
	NO_HS, 
	HS_POINTS, 
	HS_COLORS, 
	HS_TIME_LOW, 
	HS_TIME_HIGH
	}


var game_data_tutorial: Dictionary = { 
	"game": Games.TUTORIAL,
	"highscore_type": HighscoreTypes.NO_HS,
	"game_name": "Tutorial",
	"game_scene_path": "res://game/game.tscn",
	"tilemap_path": "res://game/tilemaps/tilemap_tutorial.tscn",
	"game_time_limit": 0,
	"strays_start_count": 10,
}
var game_data_eraser_S: Dictionary = { 
	"game": Games.ERASER_S,
	"highscore_type": HighscoreTypes.HS_TIME_LOW,
	"game_name": "Eraser S",
	"game_scene_path": "res://game/game_cleaning.tscn",
	"tilemap_path": "res://game/tilemaps/eraser/tilemap_eraser_S.tscn",
	"game_time_limit": 0,
	"strays_start_count": 50,
	# instructions text
	"description" : "Collect all available colors.",
	"Label": "Game is over when you lose all energy.",
	"Label2" : "Time is limited.",
}
var game_data_eraser_M: Dictionary = {
	"game": Games.ERASER_M,
	"highscore_type": HighscoreTypes.HS_TIME_LOW,
	"game_name": "Eraser M",
	"game_scene_path": "res://game/game_cleaning.tscn",
	"tilemap_path": "res://game/tilemaps/eraser/tilemap_eraser_M.tscn",
	"game_time_limit": 0,
	"strays_start_count": 140, 
	# instructions text
	"description" : "Collect all available colors.",
	"Label": "Game is over when you lose all energy.",
	"Label2" : "Time is limited.",
}
var game_data_eraser_L: Dictionary = {
	"game": Games.ERASER_L,
	"highscore_type": HighscoreTypes.HS_TIME_LOW,
	"game_name": "Eraser L",
	"game_scene_path": "res://game/game_cleaning.tscn",
	"tilemap_path": "res://game/tilemaps/eraser/tilemap_eraser_L.tscn",
	"game_time_limit": 0,
	"strays_start_count": 320, 
	# instructions text
	"description" : "Collect all available colors.",
	"Label": "Game is over when you lose all energy.",
	"Label2" : "Time is limited.",
}
var game_data_cleaner: Dictionary = {
	"game": Games.CLEANER,
	"highscore_type": HighscoreTypes.HS_POINTS,
	"game_name": "Cleaner",
	"game_scene_path": "res://game/game_cleaning.tscn",
	"tilemap_path": "res://game/tilemaps/tilemap_cleaner.tscn",
	"game_time_limit": 300,
	"strays_start_count": 320, 
	# instructions text
	"description" : "Collect colors to earn points.",
	"Label": "Game is over when you lose all energy.",
	"Label2" : "Time is limited.",
}
var game_data_cleaner_duel: Dictionary = {
	"game": Games.CLEANER_DUEL,
	"highscore_type": HighscoreTypes.NO_HS,
	"game_name": "The Duel",
	"game_scene_path": "res://game/game_cleaning.tscn",
	"tilemap_path": "res://game/tilemaps/tilemap_cleaner_duel.tscn",
	"game_time_limit": 60,
	"strays_start_count": 1000, 
	# instructions text
	"description" : "Surviving player or player with higher score wins.",
	"Label": "", # presledek
	"Label2": "Game is over when one of the players loses all life.",
	"Label3" : "Time is limited.",
}
var game_data_scroller: Dictionary = { 
	"game": Games.SCROLLER,
	"highscore_type": HighscoreTypes.HS_POINTS,
	"game_name": "Scroller",
	"game_scene_path": "res://game/game_scrolling.tscn",
	"tilemap_path": "res://game/tilemaps/tilemap_scrolling.tscn",
	"game_time_limit": 0,
	"strays_start_count": 1, # samo spawn prve runde
	# instructions text
	"description" : "Collect colors to progress through levels.",
	"Label": "Game is over when first wall column reaches the top or you have no room to move.",
	"Label2" : "Don't worry about energy.",
	"Label3" : "Skills are not available.",
	"Label4" : "Burst always collects all colors in stack.",
	"Label5" : "Unlimited levels. Unlimited time. Game is unbeatable.",
	# xtra
	# "level": 1, # level se nafila ob štartu
	"stages_per_level": 50, # vsak level prištejem k trenutnemu limitu levela
	"stages_per_level_grow": 10, # dodatno prištejem
	"lines_scroll_per_spawn_round": 1,
	# pavza med stepanjem
	"scrolling_pause_time": 0.7, # ne sem bit manjša od stray step hitrosti (0.2)
	"scrolling_pause_time_factor": 0.9, # množim z vsakim levelom
	# random spawn na rundo
	"stray_to_spawn_round_range": [1, 13], # random spawn count, največ 20
	"round_range_factor_1": 1, # množim spodnjo mejo
	"round_range_factor_2": 1, # množim zgornjo mejo
	# možnost spawna v rundi
	"round_spawn_possibility": 20, # procenti
	"round_spawn_possibility_factor": 1.2, # množim procente
}
var game_data_eternal: Dictionary = { 
	"game": Games.ETERNAL,
	"highscore_type": HighscoreTypes.HS_POINTS,
	"game_name": "Eternal",
	"game_scene_path": "res://game/game_cleaning.tscn",
	"tilemap_path": "res://game/tilemaps/tilemap_eternal.tscn",
	"game_time_limit": 0,
	"strays_start_count": 50,
	# instructions text
	"description" : "Collect points to progress through levels.",
	"Label": "Game is over when you lose all life or the screen is full of colors.",
	"Label2" : "Unlimited levels. Unlimited time. Game is unbeatable.",
	"Label3" : "Don't worry about energy.",
	# xtra
	# "level": 1, # se neafila kasneje
	"respawn_wait_time": 1,
	"respawn_wait_time_factor": 0.7, # množim z vsakim levelom
	"respawn_strays_count": 1,
	"respawn_strays_count_grow": 1, # prištejem z vsakim levelom
	"level_points_limit": 320, # vsak level prištejem k trenutnemu limitu levela
	"level_points_limit_grow": 10, # dodatno prištejem z vsakim levelom
	"level_strays_spawn_count_grow": 5, # prištejem z vsakim levelom
}
var game_data_eternal_xl: Dictionary = { 
	"game": Games.ETERNAL_XL,
	"highscore_type": HighscoreTypes.HS_POINTS,
	"game_name": "Eternal XL",
	"game_scene_path": "res://game/game_cleaning.tscn",
	"tilemap_path": "res://game/tilemaps/tilemap_eternal_xl.tscn",
	"game_time_limit": 0,
	"strays_start_count": 320,
	# instructions text
	"description" : "Collect points to progress through levels.",
	"Label": "Game is over when you lose all life or the screen is full of colors.",
	"Label2" : "Don't worry about energy.",
	"Label3" : "Unlimited levels. Unlimited time. Game is unbeatable.",
	# xtra
	# "level": 1, # se neafila kasneje
	"respawn_wait_time": 1,
	"respawn_wait_time_factor": 0.7, # množim z vsakim levelom
	"respawn_strays_count": 1,
	"respawn_strays_count_grow": 1, # prištejem z vsakim levelom
	"level_points_limit": 320, # vsak level prištejem k trenutnemu limitu levela
	"level_points_limit_grow": 10, # dodatno prištejem z vsakim levelom
	"level_strays_spawn_count_grow": 32, # prištejem z vsakim levelom
}
var game_data_enigma: Dictionary = {
	"game": Games.ENIGMA,
	"highscore_type": HighscoreTypes.HS_TIME_LOW,
	"game_name": "Enigma",
	"game_scene_path": "res://game/game_cleaning.tscn",
	"game_time_limit": 0,
	"strays_start_count": 100, 
	# instructions text
	"description" : "Collect all available colors with a single burst move.",
	"Label" : "Burst move includes initial burst and all rebursts that follow.",
	"Label2": "Burst move starts when you hit the first stray pixel.",
#	"Label3" : "Burst always collect all colors in a stack. Reburst collects only one.",
	"Label3" : "Burst and reburst always collect all colors in a stack.",
	"Label4" : "Reburst time window is limitless.",
	"Label5" : "Don't worry about energy.",
	# nafila iz level settingsov
	# "tilemap_path": 
	# "level": 
}
var enigma_level_setting: Dictionary = { 
	1: { # ključ je tudi številka levela
		"tilemap_path": "res://game/tilemaps/enigma/tilemap_enigma_01.tscn",
		"level_description": "Description ...", # pre-game instructions
	},
	2: {
		"tilemap_path": "res://game/tilemaps/enigma/tilemap_enigma_02.tscn",
		"level_description": "Description ...",
	},
	3: {
		"tilemap_path": "res://game/tilemaps/enigma/tilemap_enigma_03.tscn",
		"level_description": "Description ...",
	},
	4: {
		"tilemap_path": "res://game/tilemaps/enigma/tilemap_enigma_04.tscn",
		"level_description": "Description ...",
	},
	5: {
		"tilemap_path": "res://game/tilemaps/enigma/tilemap_enigma_05.tscn",
		"level_description": "Description ...",
	},
	6: {
		"tilemap_path": "res://game/tilemaps/enigma/tilemap_enigma_06.tscn",
		"level_description": "Description ...",
	},
	7: {
		"tilemap_path": "res://game/tilemaps/enigma/tilemap_enigma_07.tscn",
		"level_description": "Description ...",
	},
	8: {
		"tilemap_path": "res://game/tilemaps/enigma/tilemap_enigma_08.tscn",
		"level_description": "Description ...",
	},
	9: {
		"tilemap_path": "res://game/tilemaps/enigma/tilemap_enigma_09.tscn",
		"level_description": "Description ...",
	},
	
	10: {
		"tilemap_path": "res://game/tilemaps/enigma/tilemap_riddler_S.tscn",
		"level_description": "Description ...",
	},
	11: {
		"tilemap_path": "res://game/tilemaps/enigma/tilemap_riddler_M.tscn",
		"level_description": "Description ...",
	},
	12: {
		"tilemap_path": "res://game/tilemaps/enigma/tilemap_riddler_L.tscn",
		"level_description": "Description ...",
	},
}


# ON GAME START -----------------------------------------------------------------------------------


var game_settings: Dictionary # = {}
var current_game_data: Dictionary # ob štartu igre se vrednosti injicirajo v "current_game_data"
var use_custom_color_theme: bool = false


func _ready() -> void:
	
	# če greš iz menija je tole povoženo
#	var debug_game = Games.TUTORIAL
	var debug_game = Games.ENIGMA
#	var debug_game = Games.ETERNAL
#	var debug_game = Games.ETERNAL_XL
#	var debug_game = Games.CLEANER
#	var debug_game = Games.CLEANER_DUEL
#	var debug_game = Games.ERASER_S
#	var debug_game = Games.ERASER_M
#	var debug_game = Games.ERASER_L
#	var debug_game = Games.SCROLLER
	set_game_data(debug_game)
	
	
func set_game_data(selected_game) -> void:
	
	game_settings = default_game_settings.duplicate() # naloži default, potrebne spremeni ob loadanju igre
	
	match selected_game:
		Games.TUTORIAL: 
			current_game_data = game_data_tutorial
			game_settings["player_start_life"] = 3
			game_settings["game_instructions_popup"] = false
			game_settings["timer_mode_countdown"] = false
		Games.ENIGMA: 
			current_game_data = game_data_enigma
			game_settings["color_picked_points"] = 0
			game_settings["all_cleaned_points"] = 0
			game_settings["reburst_window_time"] = 0 # 0 = neomejeno
			game_settings["all_cleaned_points"] = 1 # vsaj ena točka, če ne se sploh ne pokaže ... izpiše se "SUCCESS!"
			game_settings["color_picked_points"] = 0
			game_settings["cell_traveled_energy"] = 0 # energija ni pomembna
			game_settings["lose_life_on_hit"] = true
			game_settings["timer_mode_countdown"] = false
			game_settings["spectrum_start_on"] = true
			game_settings["position_indicators_on"] = false
			game_settings["start_countdown"] = true
			game_settings["player_start_color"] = Color.white
			game_settings["reburst_hit_power"] = 2
#			game_settings["reburst_mode"] = true
			# debug
			current_game_data["level"] = 6
			game_settings["solutions_mode"] = false
		Games.ETERNAL: 
			current_game_data = game_data_eternal
			game_settings["player_start_life"] = 3
			game_settings["all_cleaned_points"] = 100
			game_settings["on_hit_points_part"] = 1
			game_settings["cell_traveled_energy"] = 0 # energija ni pomembna
			game_settings["eternal_mode"] = true
			game_settings["lose_life_on_hit"] = true
			game_settings["timer_mode_countdown"] = false
			game_settings["spectrum_start_on"] = true
			game_settings["position_indicators_on"] = false
			game_settings["turn_stray_to_wall"] = false
		Games.ETERNAL_XL: 
			current_game_data = game_data_eternal_xl
			game_settings["player_start_life"] = 3
			game_settings["all_cleaned_points"] = 100
			game_settings["on_hit_points_part"] = 1
			game_settings["cell_traveled_energy"] = 0 # energija ni pomembna
			game_settings["eternal_mode"] = true
			game_settings["lose_life_on_hit"] = true
			game_settings["timer_mode_countdown"] = false
			game_settings["spectrum_start_on"] = true
			game_settings["turn_stray_to_wall"] = true
		Games.CLEANER: 
			current_game_data = game_data_cleaner
		Games.ERASER_S: 
			current_game_data = game_data_eraser_S
			game_settings["all_cleaned_points"] = 1 # vsaj ena točka, če ne se sploh ne pokaže ... izpiše se "SUCCESS!"
			game_settings["color_picked_points"] = 0
			game_settings["timer_mode_countdown"] = false
			game_settings["start_countdown"] = true
		Games.ERASER_M: 
			current_game_data = game_data_eraser_M
			game_settings["all_cleaned_points"] = 1 # vsaj ena točka, če ne se sploh ne pokaže ... izpiše se "SUCCESS!"
			game_settings["color_picked_points"] = 0
			game_settings["timer_mode_countdown"] = false
			game_settings["start_countdown"] = true
		Games.ERASER_L: 
			current_game_data = game_data_eraser_L
			game_settings["all_cleaned_points"] = 1 # vsaj ena točka, če ne se sploh ne pokaže ... izpiše se "SUCCESS!"
			game_settings["color_picked_points"] = 0
			game_settings["timer_mode_countdown"] = false
			game_settings["start_countdown"] = true
		Games.CLEANER_DUEL: 
			current_game_data = game_data_cleaner_duel
			game_settings["player_start_life"] = 3
			game_settings["lose_life_on_hit"] = true
			game_settings["position_indicators_on"] = false 
		Games.SCROLLER:
			current_game_data = game_data_scroller
			game_settings["cell_traveled_energy"] = 0
			game_settings["all_cleaned_points"] = 0
			game_settings["zoom_animation"] = false
			game_settings["timer_mode_countdown"] = false
			game_settings["position_indicators_on"] = false 
			game_settings["player_start_color"] = Color.white
#			game_settings["game_instructions_popup"] = false
#			current_game_data["level"] = 1
