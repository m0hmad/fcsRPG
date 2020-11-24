extends Popup

var player

func _ready():
	player = get_node("/root/Root/Player")
	set_process(false)
	
func _on_Player_player_level_up():
	set_process_input(true)
	popup_centered()
	get_tree().paused = true
	# Play level up sound
	$SoundLevelUp.play()
	
func _input(event):
	if event.is_action_pressed("key_A"):
		player.health_max += 50
		player.health += 50
		hide()
		set_process_input(false)
		get_tree().paused = false
	elif event.is_action_pressed("key_B"):
		player.mana_max += 50
		player.mana += 50
		hide()
		set_process_input(false)
		get_tree().paused = false
