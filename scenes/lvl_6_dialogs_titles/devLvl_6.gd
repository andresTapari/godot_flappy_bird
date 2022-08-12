# devlvl_6.gd
extends Node2D

# Variables de exportacion
export var terrain_speed = 100

# Precarcamos los pipes
onready var PIPE = preload("res://scenes/lvl_4_colisiones/pipe_4.tscn")
onready var NAMEDIALOG = preload('res://scenes/lvl_6_dialogs_titles/name_entry_dialog.tscn')

# Cargamos nodos del hud
onready var hud_score_label = get_node("hud_score_6/score_label")
onready var hud  = get_node("hud_score_6")
#onready var hud_score_panel	= get_node("hud_score_6/score_panel")


var terrain: Array = [] 		# Lista donde guardamos el terreno
var score: int = 0				# Puntaje del jugador
var game_state: bool = true		#

func _ready() -> void:
	# Cargamos los nodos del terreno
	terrain = $Path2D.get_children()
	# Conectamos señal
	$Player_5.connect('update_score',self,'_update_score')
	$Player_5.connect('game_over',self,'_game_over_screen')
	$Player_5.connect('game_start',self,'_game_start')

func _process(delta: float) -> void:
	if game_state:
		# Movemos el terreno:
		for platform in terrain:
			platform.offset += terrain_speed * delta
 
func stop_game() -> void:
	# detenemos el terreno:
	game_state = false
	# detenemos el timer:
	$Timer.stop()
	# detenemos las tuberias:
	var pipes = get_tree().get_nodes_in_group("pipe")
	for pipe in pipes:
		pipe.speed = 0

# Señales:
func _on_Timer_timeout() -> void:
	# Creamos nueva instancia de pipe
	var newPipe = PIPE.instance()
	# Asignamos su posición del spawner
	newPipe.position = $PipeSpawner.position
	# Agregamos el nuevo nodo por debajo del spawner
	self.add_child_below_node($PipeSpawner,newPipe)

func _update_score() -> void:
	hud_score_label.text = String(score)
	
func _game_over_screen()-> void:
	
	hud.playAnimation("game_over")
	yield(hud.get_node('AnimationPlayer'),'animation_finished')
	#hud.play('game_over')
	#hud_score_panel.top_score = score
	#hud_score_panel.get_node('AnimationPlayer').play('game_over_title')
	
	# nos fijamos que el puntaje no sea maximo:
	#yield(hud_score_panel.get_node('AnimationPlayer'),'animation_finished')
	if score > SCORE.getMinimumScore():
		var newDialog = NAMEDIALOG.instance()
		$hud_score_6.add_child(newDialog)
		newDialog.get_node("AnimationPlayer").play('popUp')
		yield(newDialog.get_node("HBoxContainer/Button"),"pressed")
		var newName = newDialog.get_node('MarginContainer/VBoxContainer/HBoxContainer/LineEdit').text
		newDialog.queue_free()
		SCORE.setNewHighScore(newName,score)
	
func _game_start() -> void:
	hud.playAnimation("info_fade_away")

