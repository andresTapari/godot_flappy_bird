# devlvl_5.gd
extends Node2D

# Variables de exportacion
export var terrain_speed = 100

# Precarcamos los pipes
onready var PIPE = preload("res://scenes/lvl_4_colisiones/pipe_4.tscn")

# Cargamos el hud
onready var hud_score = get_node("hud_score_5/score_label")
onready var hud_animations = get_node("hud_score_5/AnimationPlayer")
var terrain: Array = [] 		# Lista donde guardamos el terreno
var score: int = 0				# Puntaje del jugador
var game_state: bool = true		#

func _ready() -> void:
	hud_animations.play("idle")
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
	hud_score.text = String(score)
	
func _game_over_screen()-> void:
	hud_animations.play('game_over')

func _game_start() -> void:
	hud_animations.play("info_fade_away")
