extends Node


# DEFAULT -----------------------------------------------------------------------------------


var default_player_stats: Dictionary = { # bo verjetno za vsak mode drugačen
	"player_name" : "Moe", # to ime se piše v HS procesu, če igralec pusti prazno
	"player_life" : 0, # se opredeli iz game_settings
	"player_energy" : 0, # se opredeli iz game_settings
	"player_points": 0,
	"colors_collected": 0,
	"skill_count" : 0,
	"burst_count" : 0,
	"cells_traveled" : 0,
}

var default_game_settings: Dictionary = {
	# default settings so tiste, ki so najbolj pogoste ... opisane v tutorialu
	"start_players_count": 1, # tole se seta v home > play meniju
	
	# scoring
	"all_cleaned_points": 500,
	"color_picked_points": 1,
	"color_picked_energy": 20,
	"stacked_color_picked_points": 2,
	"stacked_color_picked_energy": 20,
	"cell_traveled_points": -1,
	"cell_traveled_energy": -1,
	"skill_used_points": 0,
	"skill_used_energy": 0,
	
	# player on start
	"player_start_life": 1, # če je samo en lajf, potem se ikone skrijejo v hudu
	"player_start_energy": 192, # energija ob štartu
	"player_start_color": Color("#141414"),
	# player in game
	"player_max_energy": 192, # max energija
	"player_tired_energy": 20, # pokaže steps warning popup in hud oabrva rdeče
	"step_time_fast": 0.09, # default hitrost
	"step_time_slow": 0.15, # minimalna hitrost
	
	# game
	
	"slowdown_mode": true, # hitrost je odvisna od energije
	"slowdown_rate": 18,
	
	"gameover_countdown_duration": 5,
	
	"suddent_death_mode": false,
	"sudden_death_limit" : 20,
	
	"lose_life_on_hit": false, # uskladi s količino lajfov
	"reset_energy_on_lose_life": true,
	
	"pick_neighbor_mode": false,
	
	"minimap_on": false,
	
	"timer_mode_countdown" : true,
	
	"start_game_countdown": true,
	
	"manage_highscores": false,
	
	"skill_limit_mode": false,
	"skill_limit_count": 5,
	"burst_limit_mode": false,
	"burst_limit_count": 5,
}


# GAMES ---------------------------------------------------------------------------------------------------------


enum Games {TUTORIAL, CLEANER_S, CLEANER_M, CLEANER_L, RUNNER, DUEL, RIDDLER}
enum PlayerCount {ONE = 1, TWO}
#var start_player_count: int = PlayerCount.TWO

var current_game_data: Dictionary # ob štartu igre se vrednosti injicirajo v "current_game_data"


var game_data_runner: Dictionary = { 
	"game": Games.RUNNER,
	"game_name": "Runner",
	"level": "01",
	"tilemap_path": "res://game/tilemaps/runner_tilemap.tscn",
	"game_time_limit": 0,
	"strays_start_count": 10,
}

var game_data_riddler: Dictionary = { 
	"game": Games.RIDDLER,
	"game_name": "Riddled",
	"level": "01",
	"tilemap_path": "res://game/tilemaps/riddler/riddler_tilemap.tscn",
	"game_time_limit": 600,
	"strays_start_count": 10,
}

var game_data_tutorial: Dictionary = { 
	"game": Games.TUTORIAL,
	"game_name": "Tutorial",
	"level": "",
	"tilemap_path": "res://game/tilemaps/tutorial_tilemap.tscn",
	"game_time_limit": 0,
	"strays_start_count": 10,
}

var game_data_cleaner_S: Dictionary = { 
	"game": Games.CLEANER_S,
	"game_name": "Cleaner",
	"level": "S",
	"tilemap_path": "res://game/tilemaps/cleaner/cleaner_S_tilemap.tscn",
	"game_time_limit": 120,
	"strays_start_count": 6, # se upošteva, če ni pozicij
	"highscore": 0, # more bit, da ga greba za med igro
}

var game_data_cleaner_M: Dictionary = {
	"game": Games.CLEANER_M,
	"game_name": "Cleaner",
	"level": "M",
	"tilemap_path": "res://game/tilemaps/cleaner/cleaner_M_tilemap.tscn",
	"game_time_limit": 300,
	"strays_start_count": 140, 
	"highscore": 0,
}

var game_data_cleaner_L: Dictionary = {
	"game": Games.CLEANER_L,
	"game_name": "Cleaner",
	"level": "L",
	"tilemap_path": "res://game/tilemaps/cleaner/cleaner_L_tilemap.tscn",
	"game_time_limit": 600,
	"strays_start_count": 320, 
	"highscore": 0,
}

var game_data_duel: Dictionary = {
	"game": Games.DUEL,
	"game_name": "The Duel",
	"level": "",
	"tilemap_path": "res://game/tilemaps/duel_tilemap.tscn",
	"game_time_limit": 300,
	"strays_start_count": 230, 
	"highscore": 0,
}


# ON GAME START -----------------------------------------------------------------------------------


var game_settings: Dictionary = {}


func _ready() -> void:
	
	var current_game = Games.CLEANER_S # če greš iz menija je tole povoženo
	set_game_data(current_game)
	
func set_game_data(selected_game) -> void:
	
	game_settings = default_game_settings.duplicate() # naloži default, potrebne spremeni ob loadanju igre
	
	match selected_game:
		Games.RUNNER: 
			current_game_data = game_data_runner
			game_settings["player_start_life"] = 3
			game_settings["timer_mode_countdown"] = false
			game_settings["cell_traveled_energy"] = 0
		Games.RIDDLER: 
			current_game_data = game_data_riddler
			game_settings["cell_traveled_energy"] = 0
		Games.DUEL: 
			current_game_data = game_data_duel
			game_settings["start_players_count"] = 2
			game_settings["player_start_life"] = 3
			game_settings["lose_life_on_hit"] = true
		Games.TUTORIAL:
			current_game_data = game_data_tutorial
			game_settings["timer_mode_countdown"] = false
			game_settings["start_game_countdown"] = false
		Games.CLEANER_S: 
			current_game_data = game_data_cleaner_S
			game_settings["manage_highscores"] = true
		Games.CLEANER_M: 
			current_game_data = game_data_cleaner_M
			game_settings["manage_highscores"] = true
		Games.CLEANER_L: 
			current_game_data = game_data_cleaner_L
			game_settings["manage_highscores"] = true
		
