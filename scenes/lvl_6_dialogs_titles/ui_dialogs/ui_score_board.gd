extends VBoxContainer

# Nodos:
onready var SCORE_ELEMENT = preload("res://scenes/lvl_6_dialogs_titles/ui_dialogs/ui_score_board_element.tscn")

onready var list 	  = get_node("MarginContainer/VBoxContainer2")
onready var startList = get_node("MarginContainer/VBoxContainer2/HSeparator3")

func _ready():
	create_score_board()
	$AnimationPlayer.play('fadeIn')

func create_score_board() -> void:
	for element in SCORE.topScoreList:
		var newElement = SCORE_ELEMENT.instance()
		newElement.get_node("Label_name").text = element["name"]
		newElement.get_node("Label_score").text= String(element["score"])
		list.add_child_below_node(startList,newElement)

func _on_TextureButton2_pressed() -> void:
	get_tree().reload_current_scene()

func _on_TextureButton_pressed() -> void:
	get_tree().change_scene('res://scenes/lvl_6_dialogs_titles/titleScreen.tscn')
