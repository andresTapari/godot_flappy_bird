extends VBoxContainer

# Señales:
signal scoreBoardButton

# Nodos:
onready var score_label      = get_node("MarginContainer/VBoxContainer3/HBoxContainer/VBoxContainer2/score_label")
onready var best_score_label = get_node("MarginContainer/VBoxContainer3/HBoxContainer/VBoxContainer2/score_best")

# Variables:
var top_score:  int = 0
var best_score: int = 0
var counter:  int   = 0

func _ready():
	top_score = SCORE.currentScore
	best_score = SCORE.getMinimumScore()
	best_score_label.text = String(best_score)
	$AnimationPlayer.play('fadeIn')

func fadeOut() -> void:
	$AnimationPlayer.play('fadeOut')
	
# Funciones de Señales:
func _on_Timer_timeout():
	if counter < top_score:
		counter += 1
		score_label.text = String(counter)

func _on_AnimationPlayer_animation_finished(_anim_name):
	$Timer.start()

func _on_ReplayButton_pressed() -> void:
	#warning-ignore:RETURN_VALUE_DISCARDED
	get_tree().reload_current_scene()

func _on_ScoreBoardButton_pressed() -> void:
	emit_signal('scoreBoardButton')
