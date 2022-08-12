extends CanvasLayer

# Cargamos nodos:
onready var SCOREPANEL = preload('res://scenes/lvl_6_dialogs_titles/ui_dialogs/ui_score_panel.tscn')

func _ready():
	playAnimation("idle")

func updateScore(score: String):
	$score_label.text = score

func playAnimation(animation: String):
	$AnimationPlayer.play(animation)

func scorePanelFadeIn():
	var scorePanelDialog = SCOREPANEL.instance()
	self.add_child(scorePanelDialog)
