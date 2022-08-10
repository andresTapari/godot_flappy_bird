extends VBoxContainer

var SCORE_ELEMENT = preload("res://scenes/lvl_6_dialogs_titles/score_board_element.tscn")

func _ready():
	create_score_board()

func create_score_board() -> void:
	for element in SCORE.topScoreList:
		var newElement = SCORE_ELEMENT.instance()
		newElement.get_node("Label_name").text = element["name"]
		newElement.get_node("Label_score").text= String(element["score"])
		$MarginContainer/VBoxContainer2.add_child_below_node($MarginContainer/VBoxContainer2/HSeparator3,newElement)
