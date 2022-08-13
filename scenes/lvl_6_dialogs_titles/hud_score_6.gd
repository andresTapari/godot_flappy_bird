extends CanvasLayer

# Cargamos nodos:
onready var SCOREPANEL = preload('res://scenes/lvl_6_dialogs_titles/ui_dialogs/ui_score_panel.tscn')
onready var NAMEDIALOG = preload('res://scenes/lvl_6_dialogs_titles/ui_dialogs/ui_name_entry_dialog.tscn')
onready var SCOREBOARD = preload('res://scenes/lvl_6_dialogs_titles/ui_dialogs/ui_score_board.tscn')

var currentDialog: Control

func _ready():
	playAnimation("idle")

#func _input(event: InputEvent) -> void:
#	get_tree().get_root().set_input_as_handled()
	
func updateScore(score: String):
	$score_label.text = score

func playAnimation(animation: String):
	$AnimationPlayer.play(animation)

func scorePanelFadeIn():
	var scorePanelDialog = SCOREPANEL.instance()
	self.add_child(scorePanelDialog)

func nameDialogFadeIn():
	# Creamos la ventana de dialogo
	currentDialog = NAMEDIALOG.instance()
	# Conectamos la señal
	#warning-ignore:RETURN_VALUE_DISCARDED
	currentDialog.connect('okButtonPressed',self,'newNameEntered')
	# La agregamos al HUD
	self.add_child(currentDialog)

func newNameEntered():
	currentDialog.fadeOut()
	yield(currentDialog,'tree_exited')
	currentDialog = SCOREBOARD.instance()
	self.add_child(currentDialog)


func _on_Button_pressed() -> void:
	get_tree().paused = !get_tree().paused


func _on_Button_mouse_entered() -> void:
	$Button.mouse_filter = Control.MOUSE_FILTER_STOP
