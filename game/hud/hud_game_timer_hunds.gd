extends Control


signal sudden_death_activated # pošlje se v hud, ki javi game managerju
signal gametime_is_up # pošlje se v hud, ki javi game managerju

enum TimerStates {COUNTING, STOPPED, PAUSED}
var current_timer_state: int = TimerStates.STOPPED

var limitless_mode: bool # če je gejm tajm 0 in je count-up mode
var absolute_game_time: float # pozitiven čas igre v sekundah (na 2 decimalki)
var coundown_second: int # za uravnavanje GO odštevanja ... opredeli s v ready

var game_time_limit: int
var sudden_death_mode: bool
var sudden_death_limit: int
var stopwatch_mode: bool
var gameover_countdown_duration: int


func _ready() -> void:
	
	# večino setam ob štartu tajmerja
	modulate = Global.color_hud_text


func _process(delta: float) -> void:
	
	# če je ustavljen, se tukaj ustavim
	if not current_timer_state == TimerStates.COUNTING:
		if absolute_game_time == 0:
			if not stopwatch_mode:
				$Mins.text = "%02d" % (game_time_limit / 60)
				$Secs.text = "%02d" % (game_time_limit % 60)
				$Hunds.text = "00"
				pass				
			else:
				$Mins.text = "00"
				$Secs.text = "00"
				$Hunds.text = "00"
		return
		
	# game time
	absolute_game_time += delta # stotinke ... absouletnega uporabljam za izračune v vseh modetih
	# zaokrožim na dve decimalki
	var absolute_game_time_decimals: float = absolute_game_time - floor(absolute_game_time)
	var absolute_game_time_hundreds: float = round(absolute_game_time_decimals * 100)
	# score je sekunde + stotinke kot decimalke
	absolute_game_time = floor(absolute_game_time) + absolute_game_time_hundreds / 100
	
		
	# display
	if stopwatch_mode:	
		$Mins.text = "%02d" % floor(absolute_game_time/60)
		$Secs.text = "%02d" % (floor(absolute_game_time) - floor(absolute_game_time/60) * 60)
		$Hunds.text = "%02d" % floor((absolute_game_time - floor(absolute_game_time)) * 100)
	else:
		var game_time_left = game_time_limit - absolute_game_time # stotinke
		$Mins.text = "%02d" % (floor(game_time_left/60))
		$Secs.text = "%02d" % (floor(game_time_left) - floor(game_time_left/60) * 60)
		$Hunds.text = "%02d" % floor((game_time_left - floor(game_time_left)) * 100)	
	
	# time limits ... višja limita je prva, nižje sledijo 
	if not limitless_mode:
		# game time is up
		if absolute_game_time >= game_time_limit: 
			modulate = Global.color_red
			Global.sound_manager.play_gui_sfx("game_countdown_a")
			stop_timer()
			emit_signal("gametime_is_up") # pošlje se v hud, ki javi GM	
		# GO countdown
		elif absolute_game_time > (game_time_limit - gameover_countdown_duration):
			# za vsakič, ko mine sekunda 
			if absolute_game_time == (game_time_limit - coundown_second): 
				coundown_second -= 1
				modulate = Global.color_yellow
				Global.sound_manager.play_gui_sfx("game_countdown_b")
		# sudden death 
		elif absolute_game_time > (game_time_limit - sudden_death_limit) and sudden_death_mode: 
			modulate = Global.color_green
			emit_signal("sudden_death_activated") # pošlje se v hud, ki javi game managerju
		else:
			modulate = Global.color_hud_text
	

func reset_timer():
	absolute_game_time = 0
	modulate = Global.color_hud_text

	
func start_timer():
	
	game_time_limit = Global.game_manager.game_data["game_time_limit"]
	stopwatch_mode = Global.game_manager.game_settings["timer_mode_countdown"]
	gameover_countdown_duration = Global.game_manager.game_settings["gameover_countdown_duration"] # čas, ko je obarvan in se sliši bip bip	

	if game_time_limit == 0:
		limitless_mode = true
		stopwatch_mode = true # avtomatično pač ...
	coundown_second = gameover_countdown_duration	
		
	# reset vrendosti se zgodi na štart (ne na stop)
	absolute_game_time = 0
	current_timer_state = TimerStates.COUNTING


func pause_timer():
	
	current_timer_state = TimerStates.PAUSED
	modulate = Global.color_blue
	

func unpause_timer():
	
	current_timer_state = TimerStates.COUNTING
	
		
func stop_timer():
	
	current_timer_state = TimerStates.STOPPED
	modulate = Global.color_red
