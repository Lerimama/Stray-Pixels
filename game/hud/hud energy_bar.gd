extends HBoxContainer


var energy: int setget _on_amount_change # energija je konveratana v razmerju velikosti bara
var previous_energy: int # preverjam smer spremembe lajfa
onready var player_tired_energy: int = Profiles.game_rules["player_tired_energy"]
#var low_energy_level: float = 0.2 # 10% ... going red 

onready var texture_progress: TextureProgress = $TextureProgress


func _ready() -> void:
	
	set_icons_state() # preveri lajf na začetku in seta pravilno stanje ikon 


func _process(delta: float) -> void:
	
	self.energy = Global.game_manager.player_stats["player_energy"]
	
	
func _on_amount_change(new_value):
	
	# setam prev energy ... pravi_life count se še ni spremenil
	previous_energy = energy 
	
	# setam current energy
	energy = new_value # v bistvu Global.game_manager.player_stats["player_energy"]
	
	if energy <= player_tired_energy:
		modulate = Global.color_red
	
	set_icons_state()
 

func set_icons_state():
	
	texture_progress.value = energy
