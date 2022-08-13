extends Node2D

onready var SCOREBOARD = preload('res://scenes/lvl_6_dialogs_titles/ui_dialogs/ui_score_board.tscn')

export var terrain_speed = 100

var terrain: Array = [] #lista donde guardamos los nodos

func _ready() -> void:
	terrain = $Path2D.get_children()

func _process(delta: float) -> void:
	for platform in terrain:
		platform.offset += terrain_speed * delta

func _on_playButton_pressed() -> void:
	get_tree().change_scene('res://scenes/lvl_6_dialogs_titles/devLvl_6.tscn')


func _on_scoreBoardButton_pressed() -> void:
	$CanvasLayer/AnimationPlayer.play('fadeAway')
	yield($CanvasLayer/AnimationPlayer,'animation_finished')
	var newDialog = SCOREBOARD.instance()
	newDialog.get_node('HBoxContainer/TextureButton2').visible = false
	$CanvasLayer.add_child(newDialog)
