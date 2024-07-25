extends HTTPRequest


var token: String
var player_id: String
var player_name: String = "NN"


func _ready() -> void:
	
	timeout = 5.0 # ker je autoload mu ne moram settat settingsih	
	
	
func authenticate_player(): # get OS uniq ID
	if player_name == "NN":
		# separacija glede na OS
		match OS.get_name():
			"HTML5", "Windows", "X11":
				player_id = OS.get_unique_id()
				authenticate_guest_session()
	else:
		player_id = player_name
		authenticate_guest_session()	
	# print (OS.get_unique_id())


func authenticate_guest_session():
	
	var url: String = "https://api.lootlocker.io/game/v2/session/guest"
	var header: Array = ["Content-Type: application/json"]
	var method = HTTPClient.METHOD_POST
	
	var request_body: Dictionary = {
		"game_key": "dev_5a1cab01df0641c0a5f76450761ce292", # lootlocker key
		"game_version": "0.92", # verzija igre (za vedenje kaj je kje)
		"player_identifier": player_id,  # glede na OS
		"development_mode": true,
	}
	
	request(url, header,false, method, to_json(request_body)) 

	# čakam na odgovor od lootlockerja ... zato dam yield
	var response = yield(self, "request_completed")[3] # 3 je body
	response = JSON.parse(response.get_string_from_utf8()).result # dobimo session token key
	
	# ni interneta?
	if response == null:
		# printt("No internet connection ...", response)
		ConnectCover.on_connection_failed()
	else:
		if "session_token" in response:
			token = response["session_token"]
			# printt("Player token connected", token)
			ConnectCover.on_connected()
		else:
			# printt("Connecting to requested site failed", response)
			ConnectCover.on_connection_failed()



#extends HTTPRequest

# prikaz spletne lestvice v igri
#var board
#
#func get_lootlocker_leaderboard():
#
#	ConnectCover.start_connecting()
#
#	var url = "https://api.lootlocker.io/game/leaderboards/PAclassic/list?count=10" #koliko mest rabimo
#	var header = ["Content-Type: application/json", "x-session-token: %s" % LootLocker.token]
#	var method = HTTPClient.METHOD_GET
#
#	request(url, header, false, method) 
#	# request(url, header,false, method, to_json(request_body)) 
#	var response = yield(self, "request_completed")[3] # to_json(request_body
#	response = JSON.parse(response.get_string_from_utf8()).result # dobimo session token key
#	print(response)
#
#	if "items" in response:
#		board = response["items"]
#
#	print(board)
#	return board