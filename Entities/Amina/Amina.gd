extends StaticBody2D

enum QuestStatus { NOT_STARTED, STARTED, COMPLETED }
var quest_status = QuestStatus.NOT_STARTED
var dialogue_state = 0
var necklace_found = false

var dialoguePopup
var player
enum Potion { HEALTH, MANA }

func _ready():
	dialoguePopup = get_tree().root.get_node("Root/Player/GUI/DialoguePopup")
	player = get_tree().root.get_node("Root/Player")
	
func talk(answer = ""):
	# Set Fiona's animation to "talk"
	$AnimatedSprite.play("talk")
	
	# Set dialoguePopup npc to Fiona
	dialoguePopup.npc = self
	dialoguePopup.npc_name = "Амина"
	
	# Show the current dialogue
	match quest_status:
		QuestStatus.NOT_STARTED:
			match dialogue_state:
				0:
					# Update dialogue tree state
					dialogue_state = 1
					# Show dialogue popup
					dialoguePopup.dialogue = "Мохьмад, са ожерелье ейна дехьа хи йисте байт1и, карор яцар те хьун?"
					dialoguePopup.answers = "[A] Х1инцехь  [B] Йиш яц"
					dialoguePopup.open()
				1:
					match answer:
						"A":
							# Update dialogue tree state
							dialogue_state = 2
							# Show dialogue popup
							dialoguePopup.dialogue = "Дел рез хил!"
							dialoguePopup.answers = "[A] Со хьавог1ун"
							dialoguePopup.open()
						"B":
							# Update dialogue tree state
							dialogue_state = 3
							# Show dialogue popup
							dialoguePopup.dialogue = "Хьо ваьлч со кхузахь хир юн, сун ца кар йо и"
							dialoguePopup.answers = "[A] Со хьавог1ун"
							dialoguePopup.open()
				2:
					# Update dialogue tree state
					dialogue_state = 0
					quest_status = QuestStatus.STARTED
					# Close dialogue popup
					dialoguePopup.close()
					# Set Fiona's animation to "idle"
					$AnimatedSprite.play("idle")
				3:
					# Update dialogue tree state
					dialogue_state = 0
					# Close dialogue popup
					dialoguePopup.close()
					# Set Fiona's animation to "idle"
					$AnimatedSprite.play("idle")
		QuestStatus.STARTED:
			match dialogue_state:
				0:
					# Update dialogue tree state
					dialogue_state = 1
					# Show dialogue popup
					dialoguePopup.dialogue = "Карири хьун и Мохьмад?"
					if necklace_found:
						dialoguePopup.answers = "[A] Х1аъ  [B] Ца карина"
					else:
						dialoguePopup.answers = "[A] Лоьхш ву"
					dialoguePopup.open()
				1:
					if necklace_found and answer == "A":
						# Update dialogue tree state
						dialogue_state = 2
						# Show dialogue popup
						dialoguePopup.dialogue = "Ваа ма дик дар и, мамс эц яр сун и"
						dialoguePopup.answers = "[A] Лар е"
						dialoguePopup.open()
					else:
						# Update dialogue tree state
						dialogue_state = 3
						# Show dialogue popup
						dialoguePopup.dialogue = "Кар йой хьажа хьайн"
						dialoguePopup.answers = "[A] Хьожаш ву!"
						dialoguePopup.open()
				2:
					# Update dialogue tree state
					dialogue_state = 0
					quest_status = QuestStatus.COMPLETED
					# Close dialogue popup
					dialoguePopup.close()
					# Set Fiona's animation to "idle"
					$AnimatedSprite.play("idle")
					# Add potion and XP to the player. 
					yield(get_tree().create_timer(0.5), "timeout") #I added a little delay in case the level advancement panel appears.
					player.add_potion(Potion.HEALTH)
					player.add_xp(50)
				3:
					# Update dialogue tree state
					dialogue_state = 0
					# Close dialogue popup
					dialoguePopup.close()
					# Set Fiona's animation to "idle"
					$AnimatedSprite.play("idle")
		QuestStatus.COMPLETED:
			match dialogue_state:
				0:
					# Update dialogue tree state
					dialogue_state = 1
					# Show dialogue popup
					dialoguePopup.dialogue = "Вайш зоопарке мац доьд"
					dialoguePopup.answers = "[A] Сай масть хилч"
					dialoguePopup.open()
				1:
					# Update dialogue tree state
					dialogue_state = 0
					# Close dialogue popup
					dialoguePopup.close()
					# Set Fiona's animation to "idle"
					$AnimatedSprite.play("idle")
					
func to_dictionary():
	return {
		"quest_status" : quest_status,
		"necklace_found" : necklace_found
	}
	
func from_dictionary(data):
	necklace_found = data.necklace_found
	quest_status = int(data.quest_status)
