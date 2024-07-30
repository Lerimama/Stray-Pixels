extends VBoxContainer


var sweeper_scorelines: Array
var current_sweeper_table_page: int = 1
var scorelines: Array = []
var scorelines_with_score: Array

onready var highscore_table: VBoxContainer = $TableScroller/Table
onready var table_title_label: Label = $Title
onready var local_rank_node_name: String = "Rank"
onready var global_rank_node_name: String = "GlobalRank"
onready var owner_node_name: String = "Owner"
onready var score_node_name: String = "Score"
onready var scoreline_empty_line_name: String = "NoScoreLine"

var show_scoreline_titles: bool = true


func _ready() -> void:
	
	pass

	
func load_highscore_table(current_game_data: Dictionary, current_player_rank: int, lines_to_load_count, global_highscores: bool = false):
	
	# reset table
	for scoreline in scorelines:
		if not scoreline == scorelines[0]:
			highscore_table.remove_child(scoreline)
	scorelines.clear()
	scorelines_with_score.clear()
	
	if global_highscores: # home globale tabel
		table_title_label.text = current_game_data["game_name"] + " Global Top %s" % lines_to_load_count
	else:
		table_title_label.text = current_game_data["game_name"] + " Top 10"
		
		
	if lines_to_load_count > 10:
		$TableScroller.scroll_vertical_enabled = true
	else:
		$TableScroller.scroll_vertical_enabled = false
	
	var current_game_highscores = Global.data_manager.read_highscores_from_file(current_game_data, global_highscores)
	
	build_table(lines_to_load_count)
	for unfilled_scoreline in scorelines: # scrolline so postavljene in ne nafilane
		fill_scoreline(unfilled_scoreline, current_game_data, lines_to_load_count, current_game_highscores)

	set_first_scoreline()
	
	for table_line in highscore_table.get_children(): # zajamem tudi HS titles linijo
		if global_highscores:
			table_line.get_node(global_rank_node_name).show()
			table_line.get_node(local_rank_node_name).hide()
		else:
			table_line.get_node(global_rank_node_name).show()
			table_line.get_node(local_rank_node_name).show()
	
	if current_player_rank > 0 and current_player_rank <= lines_to_load_count:
		var players_scoreline: Control = scorelines[current_player_rank - 1]
		players_scoreline.modulate = Global.color_green
	
	
func build_table(lines_count: int):
	
	scorelines = highscore_table.get_children()
	
	var scoreline_titles_line: Control
	if show_scoreline_titles: # odstranim scoreline titles line
		scoreline_titles_line = scorelines.pop_front()
		scoreline_titles_line.modulate = Global.color_gui_gray
	
	# podupliciram osnovno linijo 
	if scorelines.size() < lines_count:
		var missing_lines_count: int = lines_count - scorelines.size()
		var scoreline_to_duplicate: Control = highscore_table.get_child(0)
		for n in missing_lines_count:
			var new_scoreline = scoreline_to_duplicate.duplicate()
			highscore_table.add_child(new_scoreline)
			scorelines.append(new_scoreline)	

				
func fill_scoreline(scoreline: Control, game_data: Dictionary, lines_count: int, highscores: Dictionary):
	
	# za vsako pozicijo vpišemo vrednost, ime in pozicijo
	var scoreline_index: int = scorelines.find(scoreline)
	var scoreline_position_key: String = "%02d" % (scoreline_index + 1)
	
	# izberem position slovar glede na pozicijo score lineta
	var current_position_dict: Dictionary = highscores[scoreline_position_key]
	var current_position_dict_values: Array = current_position_dict.values()
	var current_position_dict_owners: Array = current_position_dict.keys()
	var current_owner: String = current_position_dict_owners[0]
	
	scoreline.get_node(local_rank_node_name).text = str(scoreline_index + 1) + "."
	scoreline.get_node(global_rank_node_name).text = str(scoreline_index + 1) + "."
	scoreline.get_node(owner_node_name).text = current_owner
	
	var current_game_hs_type = game_data["highscore_type"]
	if current_game_hs_type == Profiles.HighscoreTypes.TIME:
		var current_position_seconds: float = current_position_dict_values[0]
		# skorlinije, ki niso skrite v hometu, se prikažejo
		if current_position_seconds > 0:# and not scoreline_index >= lines_to_load_count: # and scoreline_index > lines_to_load_count:
			scoreline.get_node(scoreline_empty_line_name).hide()
			scoreline.get_node(score_node_name).text = Global.get_clock_time(current_position_seconds)
			scorelines_with_score.append(scoreline)
		# skrijem 0 rezultat
		elif current_position_seconds == 0:
			scorelines_with_score.erase(scoreline)
			scoreline.get_node(local_rank_node_name).hide()
			scoreline.get_node(owner_node_name).hide()
			scoreline.get_node(score_node_name).hide()
			scoreline.get_node(scoreline_empty_line_name).show()
			
	elif current_game_hs_type == Profiles.HighscoreTypes.POINTS:
		var current_position_points: int = current_position_dict_values[0]
		if current_position_points > 0:
			scoreline.get_node(scoreline_empty_line_name).hide()
			scoreline.get_node(score_node_name).text = str(current_position_points)
			scorelines_with_score.append(scoreline)
		# skrijem 0 rezultat
		else:
			scorelines_with_score.erase(scoreline)
			scoreline.get_node(local_rank_node_name).hide()
			scoreline.get_node(owner_node_name).hide()
			scoreline.get_node(score_node_name).hide()
			scoreline.get_node(scoreline_empty_line_name).show()
	
	# pokažem samo lines_to_load_count 		
	scoreline.modulate = Global.color_almost_white_text
	if not scoreline_index > lines_count:
		scoreline.show()
	else:
		scoreline.hide()
			

func set_first_scoreline():

	# če v lestvici ni rezultata, priredim prvo vrstico, če ne jo vrnem v planiran položaj
	if scorelines_with_score.empty():
		scorelines[0].show() # 0 je title
		scorelines[0].get_node(owner_node_name).clip_text = false
		scorelines[0].get_node(owner_node_name).text = "Still no score ..."
		scorelines[0].get_node(owner_node_name).align = Label.ALIGN_CENTER
		scorelines[0].get_node(owner_node_name).modulate = Global.color_almost_white_text
		scorelines[0].get_node(owner_node_name).show()
		scorelines[0].get_node(local_rank_node_name).hide()
		scorelines[0].get_node(score_node_name).hide()
		scorelines[0].get_node(scoreline_empty_line_name).hide()
	else: # zazih
		scorelines[0].get_node(owner_node_name).clip_text = true
		scorelines[0].get_node(owner_node_name).align = Label.ALIGN_LEFT
		scorelines[0].get_node(local_rank_node_name).show()
		scorelines[0].get_node(score_node_name).show()
		

func load_local_to_global_ranks(local_game_data: Dictionary):#, global_game_data: Dictionary):
	
	var global_game_highscores: Dictionary = Global.data_manager.read_highscores_from_file(local_game_data, true)
	var scorelines_with_global_rank: Array = [] # za označit ne povezane
	
	# za vsak global skor, preverim vse lokalne scoreline
	for global_highscore_line in global_game_highscores:
		
		var global_highscore_player_name: String = global_game_highscores[global_highscore_line].keys()[0]
		var global_highscore_player_score: float = global_game_highscores[global_highscore_line][global_highscore_player_name]
		var global_highscore_player_rank = global_highscore_line
		
		# dodam rank k tistim, ki ga imajo	
		for scoreline in scorelines_with_score:
			var scoreline_name: String = scoreline.get_node(owner_node_name).text
			var scoreline_score: String = scoreline.get_node(score_node_name).text
			# preverim enakost imena in skora
			if global_highscore_player_name == scoreline_name and str(global_highscore_player_score) == scoreline_score:
				scoreline.get_node(global_rank_node_name).text = str(global_highscore_player_rank) + "."
				scorelines_with_global_rank.append(scoreline)
				break
	
	# označim tiste brez ranka
	for scoreline in scorelines_with_score:
		if not scorelines_with_global_rank.has(scoreline):
			scoreline.get_node(global_rank_node_name).text = "..."					
