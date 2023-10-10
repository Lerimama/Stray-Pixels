extends Node


# STATS ---------------------------------------------------------------------------------------------------------


var default_level_highscores: Dictionary = { # prazen slovar ... uporabi se ob kreiranju fileta ... uporabi ga Glo
# če id uporabim kot gole številke, se vseeno prebere kot string
	"1": {"First": 9,},
	"2": {"Second": 8,},
	"3": {"Third": 7,},
	"4": {"Fourth": 6,},
	"5": {"Fifth": 5,},
	"6": {"Sixth": 4,},
	"7": {"Seventh": 3,},
	"8": {"Eighth": 2,},
	"9": {"Ninth": 1,},
}

var default_player_stats : Dictionary = { # bo verjetno za vsak mode drugačen
	"player_name" : "Nobody", # to ime se piše v HS procesu, če igralec pusti prazno
	"player_life" : 3,
	"player_points": 0,
	"player_energy" : 192, # tukaj določena je nepomembna, ker se jo na začetku opredeli iz gam settings
	"skill_count" : 0,
	"burst_count" : 0,
	"cells_travelled" : 0,
}


# === GAMES ===


enum Levels {PRACTICE, S, M, L, XL, XXL}

var default_level_stats : Dictionary = { # na štartu igre se tole duplicira in postane game stats
	"level" : Levels.PRACTICE,
	"game_time_limit" : 5, # sekund
	"stray_pixels_count" : 32,
	"off_pixels_count" : 0,
	"highscore": 0000, # se naloži iz  "default_level_highscores" lestvice ob štartu igre, zato, da te lahko opozori že med igro
	"highscore_owner": "Nobody", # se naloži iz  "default_level_highscores" lestvice ob štartu igre, zato, da te lahko opozori že med igro
}

# na štartu se vrednosti injicirajo v "default_level_stats"

var level_1_stats : Dictionary = { 
	"level": Levels.S,
	"game_time_limit": 5,
	"stray_pixels_count": 5,
}

var level_2_stats : Dictionary = {
	"level": Levels.M,
	"game_time_limit": 120,
	"stray_pixels_count": 32, 
}

var level_3_stats : Dictionary = {
	"level": Levels.L,
	"game_time_limit": 180,
	"stray_pixels_count": 140, 
}

var level_4_stats : Dictionary = {
	"level": Levels.XL,
	"game_time_limit": 240,
	"stray_pixels_count": 230, 
}

var level_5_stats : Dictionary = {
	"level": Levels.XXL,
	"game_time_limit": 300,
	"stray_pixels_count": 320, 
}


var game_rules: Dictionary = { # tole ne uporabljam v zadnji varianti
	
	"color_picked_points": 10, # GM
	"color_picked_energy": 20, # GM
	"additional_color_picked_points": 20, # GM
	"additional_color_picked_energy": 40, # GM
	"cell_travelled_points": -1, # GM
	"cell_travelled_energy": -1, # GM
	"skill_used_points": 0, # GM ... isto kot stepanje
	"skill_used_energy": 0, # GM
	"skilled_energy_drain": -1, # GM
	"wall_hit_points": 0, # GM
	"wall_hit_energy": -96, # GM
	"skilled_energy_drain_speed": 0.1, # GM ... čas med vsakim odvzemom
	"player_start_energy": 192, # GM
	"dead_time": 5, # GM
	"tired_energy": 32, # player ... procent cele energije
	"min_player_alpha": 0.2, # player
	"player_max_energy": 192, # player .. max, da se lepo ujema s pixli (24)
	"max_step_time": 0.15, # player
	"min_step_time": 0.09, # player
	"burst_speed_addon": 12, # player ... dodatek hitrosti na cock_ghost
	"gameover_countdown_duration": 10, # hud game timer
	"last_breath_loop_limit": 3, # cca 1 bit na sekundo
	"pixel_start_color": Color("#141414"),
	"intro_strays_count": 149,  # 149 celic je v naslovu, kar je več gre naokrog
	"death_mode_duration" : 20,
	
		
	# config ... ne vem če je vse za ta slovar?
	"timer_countdown_mode" : true,
	"pick_neighbour_mode": false, # hud, player
	"deathmode_on": true, # hud_game_timer
	"last_breath_mode": true, # player
	"minimap_on": false, # game
	"game_countdown_on": false, # game_countdown
	"energy_speed_mode": true, # GM, player
	"loose_life_on": true, # GM ... v tem primeru, ne izgubiš energije niti točk
	"revive_energy_reset": true,  # GM
	"stop_burst_mode": true,  # player
	"randomize_stray_spawning": false,  # GM
	"skill_limit_mode": false,
	"skill_limit_count": 5,
	"burst_limit_mode": false,
	"burst_limit_count": 5,
}
