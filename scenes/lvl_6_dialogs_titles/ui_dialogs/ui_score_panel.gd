extends VBoxContainer

var top_score: int = 0
var counter: int   = 0

onready var score_label      = get_node("MarginContainer/VBoxContainer3/HBoxContainer/VBoxContainer2/score_label")
onready var best_score_label = get_node("MarginContainer/VBoxContainer3/HBoxContainer/VBoxContainer2/score_best")

func _ready():
	top_score = SCORE.currentScore
	$AnimationPlayer.play('fadeIn')

# Señales:
func _on_Timer_timeout():
	if counter < top_score:
		counter += 1
		score_label.text = String(counter)
func _on_AnimationPlayer_animation_finished(_anim_name):
	$Timer.start()

func _on_Button_redoo_pressed():
	#warning-ignore:RETURN_VALUE_DISCARDED
	get_tree().reload_current_scene()

func _on_Button_ok_pressed():
	pass
