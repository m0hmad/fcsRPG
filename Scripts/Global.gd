extends Node

var stat_palyer = {
		"position" : [160, 90],
		"health" : 100,
		"health_max" : 100,
		"mana" : 100,
		"mana_max" : 100,
		"xp" : 0,
		"xp_next_level" : 100,
		"level" : 1,
		"health_potions" : 0,
		"mana_potions" : 0
	}

var current_scene = null

func _ready():
	var root = get_tree().get_root()
	current_scene = root.get_child(root.get_child_count() - 1)
 
func goto_scene(path):
	get_node("/root/Root").queue_free()
	get_tree().change_scene(path)
	print(path) #debag
#	call_deferred("_deferred_goto_scene", path)
	
#func _deferred_goto_scene(path):
#	current_scene.free() #Attempt to call function 'free' in base 'null instance' on a null instance
	
#	var s = ResourceLoader.load(path)	
#	current_scene = s.instance()
	
#	get_tree().get_root().add_child(current_scene)
#	get_tree().set_current_scene(current_scene)
#	$Player.from_dictionary(stat_palyer)  #Attempt to call function 'from_dictionary' in base 'null instance' on a null instance
