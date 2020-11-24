extends Area2D

export var next_scene = "res://Scenes/Forest.tscn"
export var position_tranzit_player = Vector2(55, 275)

func _on_TranzitZone_body_entered(body):
	if body.name == "Player":
		Global.stat_palyer = get_node("/root/Root/Player").to_dictionary()
		Global.stat_palyer["position"] = position_tranzit_player
		Global.goto_scene(next_scene)
	
	
	
	
