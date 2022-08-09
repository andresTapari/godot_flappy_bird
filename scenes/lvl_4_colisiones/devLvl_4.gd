extends Node2D

# Variables de exportacion
export var terrain_speed = 100

# Precarcamos los pipes
onready var PIPE = preload("res://scenes/lvl_4_colisiones/pipe_4.tscn")

var terrain: Array = [] 		# Lista donde guardamos el terreno
var score: int = 0				# Puntaje del jugador
var game_state: bool = true		#

func _ready() -> void:
	terrain = $Path2D.get_children()

func _process(delta: float) -> void:
	if game_state:
		# Movemos el terreno:
		for platform in terrain:
			platform.offset += terrain_speed * delta

func stop_game():
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
