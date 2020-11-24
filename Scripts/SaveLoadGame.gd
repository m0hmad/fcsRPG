extends Node
export var scene = "res://Scenes/Main.tscn"
var load_saved_game = false

func _ready():
	var file = File.new()
	
	if load_saved_game and file.file_exists("user://savegame.json"):
		file.open("user://savegame.json", File.READ)
		var data = parse_json(file.get_as_text())
		file.close()
		
		$Player.from_dictionary(data.player)
		$Amina.from_dictionary(data.amina)
		$SkeletonSpawner.from_dictionary(data.skeletons)
		if($Amina.necklace_found):
			$Necklace.queue_free()
		if(not data.health):
			$Mana.queue_free()
		if(not data.mana):
			$Health.queue_free()
			
			
func save():
	var data = {
		"scene" : scene,
		"player" : $Player.to_dictionary(),
		"amina" : $Amina.to_dictionary(),
		"skeletons" : $SkeletonSpawner.to_dictionary(),
		"health" : is_instance_valid(get_node("/root/Root/Health")),
		"mana" : is_instance_valid(get_node("/root/Root/Mana"))
	}
	
	var file = File.new()
	file.open("user://savegame.json", File.WRITE)
	var json = to_json(data)
	file.store_line(json)
	file.close()
