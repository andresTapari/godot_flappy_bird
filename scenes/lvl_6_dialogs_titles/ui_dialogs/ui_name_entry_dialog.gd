extends VBoxContainer

# Señales:
signal okButtonPressed

# Nodos
onready var okButton   = get_node("HBoxContainer/Button")
onready var lineEdit   = get_node("MarginContainer/VBoxContainer/HBoxContainer/LineEdit")
onready var scoreLabel = get_node('MarginContainer/VBoxContainer/ScoreLabel')

func _ready() -> void:
	scoreLabel.text = String(SCORE.currentScore)
	$AnimationPlayer.play('popUp')

func fadeOut() -> void:
	$AnimationPlayer.play('popOut')

# Funciones de Señales:
func _on_LineEdit_text_changed(new_text: String) -> void:
	if !new_text.empty():
		okButton.disabled = false
	else:
		okButton.disabled = true

func _on_Button_pressed() -> void:
	var newName = lineEdit.text
	SCORE.setNewHighScore(newName)
	emit_signal("okButtonPressed")