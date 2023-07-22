extends Node2D


var skill_success_count: int = 0


# grupe zvokov	
onready var stepping: Node2D = $GameSfx/Stepping
onready var blinking: Node2D = $GameSfx/Blinking
onready var blinking_static: Node2D = $GameSfx/BlinkingStatic
onready var burst: Node2D = $GameSfx/Burst
onready var music: Node2D = $Music


func _ready() -> void:
	Global.sound_manager = self
	randomize()
	

func play_sfx(effect_for: String):
	
	# če zvoka ni tukaj, pomeni da ga kličem direktno
	match effect_for:
		
		"stepping": # tudi za tipkanje 
			select_random_sfx(stepping).play()
		"blinking":
			select_random_sfx(blinking_static).play()
			select_random_sfx(blinking).play()
		"last_breath":
			if $GameSfx/LastBeat.is_playing():
				return
			$GameSfx/LastBeat.play()
		
		# bursting
		"hit_stray":
			$GameSfx/Burst/HitStray.play()
		"hit_wall":
			$GameSfx/Burst/HitWall.play()
			$GameSfx/Burst/HitDizzy.play()
		"burst":
			yield(get_tree().create_timer(0.1), "timeout")
			$GameSfx/Burst/Burst.play()
			$GameSfx/Burst/BurstLaser.play()
		"burst_cocking":
			if $GameSfx/Burst/BurstCocking.is_playing():
				return
			$GameSfx/Burst/BurstCocking.play()	
							
		# skills
		"pull":
			$GameSfx/Skills/Pull.play()
		"pulled":
			$GameSfx/Skills/Pulled.play()
			$GameSfx/Skills/PullStoneSlide.play()
		"push":
			$GameSfx/Skills/Pull.play()
		"pushed":
			$GameSfx/Skills/Pulled.play()
			$GameSfx/Skills/PushStoneSlide.play()
		"teleport":
			$GameSfx/Skills/TeleportIn.play()
		"skilled":
			$GameSfx/Skills/Skilled.play()
		"skill_fail":
			$GameSfx/Skills/SkillFail.play()
		"skill_success":
#			skill_success_count += 1
#			if skill_success_count < Profiles.game_rules["skills_in_row_limit"]:
#				$GameSfx/Skills/SkillSuccessA.play()
#			else:
#				$GameSfx/Skills/SkillSuccessB.play()
#				skill_success_count = 0
			pass
			
		# events
		"countdown_a":
			$GameSfx/Events/CoundownA.play()
		"countdown_b":
			$GameSfx/Events/CoundownB.play()
		"win_jingle":
			$GameSfx/Events/Win.play()
		"loose_jingle":
			$GameSfx/Events/Loose.play()
		"record_cheers":
			$GameSfx/Events/RecordCheers.play()
			
		# gui
		"btn_confirm":
			$GuiSfx/BtnConfirm.play()
		"btn_cancel":
			$GuiSfx/BtnCancel.play()
		"btn_focus_change":
			$GuiSfx/BtnFocus.play()
		"menu_fade":
			$GuiSfx/MenuFade.play()
		"screen_slide":
			$GuiSfx/ScreenSlide.play()
			
			
func stop_sfx(sfx_to_stop: String):
	
	match sfx_to_stop:
			"teleport":
				$GameSfx/Skills/TeleportLoop.stop()
				$GameSfx/Skills/TeleportOut.play()
			"skilled":
				$GameSfx/Skills/Skilled.stop()
			"burst_cocking":
				$GameSfx/Burst/BurstCocking.stop()
			"last_breath":
				$GameSfx/LastBeat.stop()


func select_random_sfx(sound_group):
	
	var random_index = randi() % sound_group.get_child_count()
	var selected_sound = sound_group.get_child(random_index)
	return selected_sound
	
	
func _on_TeleportStart_finished() -> void:
	$GameSfx/Skills/TeleportLoop.play()
	
		
# MUSKA --------------------------------------------------------------------------------------------------------


var current_music_index = 1 # ga ne resetiraš, da ostane v spominu skozi celo igro
onready var game_music: Node2D = $Music/GameMusic


func _input(event: InputEvent) -> void:
	
	if Input.is_action_just_pressed("n"):
		skip_music()
		
	if Input.is_action_just_pressed("m"):
		if game_music.get_child(current_music_index - 1).stream_paused == false:
			game_music.get_child(current_music_index - 1).stream_paused = true
			Global.hud.music_label.get_node("OffIcon").visible = true
			Global.hud.music_label.get_node("OnIcon").visible = false
			
		else:
			game_music.get_child(current_music_index - 1).stream_paused = false
			Global.hud.music_label.get_node("OnIcon").visible = true
			Global.hud.music_label.get_node("OffIcon").visible = false


func play_music(music_for: String):
	
	match music_for:
		"menu":
			$Music/MenuMusic/WarmUpShort.play()
		"game":
			game_music.get_child(current_music_index - 1).play()
			Global.hud.music_label.text = "%02d" % current_music_index
			printt("music_index ", current_music_index)	
			
			# če je na pavzi ga odpavzam
			game_music.get_child(current_music_index - 1).stream_paused = false
			Global.hud.music_label.get_node("OnIcon").visible = true
			Global.hud.music_label.get_node("OffIcon").visible = false
			


func stop_music(music_to_stop: String):
	
	match music_to_stop:
		
		"menu":
			var fade_out = get_tree().create_tween().set_ease(Tween.EASE_IN_OUT)	
			fade_out.tween_property($Music/MenuMusic/WarmUpShort, "volume_db", -80, 0.5)
			fade_out.tween_callback($Music/MenuMusic/WarmUpShort, "stop")
		
		"game":
			for music in game_music.get_children():
				if music.is_playing():
					var current_music_volume = music.volume_db
					var fade_out = get_tree().create_tween().set_ease(Tween.EASE_IN_OUT)	
					fade_out.tween_property(music, "volume_db", -80, 1)
					fade_out.tween_callback(music, "stop")
					fade_out.tween_property(music, "volume_db", current_music_volume, 0.1) # reset glasnosti
#					return


func skip_music():	
	
	current_music_index += 1
	
	if current_music_index > game_music.get_child_count():
		current_music_index = 1
	
	for music in game_music.get_children():
		if music.is_playing():
			var current_music_volume = music.volume_db
			var fade_out = get_tree().create_tween().set_ease(Tween.EASE_IN_OUT)	
			fade_out.tween_property(music, "volume_db", -80, 0.5)
			fade_out.tween_callback(music, "stop")
			fade_out.tween_property(music, "volume_db", current_music_volume, 0.1) # reset glasnosti
			fade_out.tween_callback(self, "play_music", ["game"]).set_delay(0.5)
			return

			
	
## random gumbi -------------------------------------------------------------------------------------
#
#onready var game: Node2D = $GameSfx
#onready var gui: Node2D = $GuiSfx
#var game_click_count = 0
#var gui_click_count = 0
#
#onready var all_game_sounds: Array = game.get_children()
#onready var all_gui_sounds: Array = gui.get_children()
#
#
#func na_gumbe(sfx_name =  null):
#
#	var all_sounds = all_gui_sounds
#	var sound_to_play = all_sounds[sfx_name]
#	sound_to_play.play()
#
#	if sfx_name:
#		get_node(sfx_name).play()
#	else:
#		var c = randi() % get_child_count()
#		get_child(c).play() 
#
#
### OLD ------------------------------------------------------------------------------------------------
#
#
#func _on_GameSfxBtn_button_up() -> void:
#
#	all_game_sounds[game_click_count].play()
#
#	printt ("game_click_count", game_click_count, game.get_child_count())
#	game_click_count += 1 
#	if game_click_count == game.get_child_count():
#		game_click_count = 0	
#
#
#func _on_GuiSfxBtn_button_up() -> void:
#
#	all_gui_sounds[gui_click_count].play()
#	printt ("gui_click_count", gui_click_count, gui.get_child_count())
#	gui_click_count += 1 
#	if gui_click_count == gui.get_child_count():
#		gui_click_count = 0	
#
#
#func _on_ResetCountBtn_pressed() -> void:
#	game_click_count = 0
#	gui_click_count = 0

