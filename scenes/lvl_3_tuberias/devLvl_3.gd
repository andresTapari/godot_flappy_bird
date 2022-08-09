extends Node2D

# Variables de exportacion
export var terrain_speed = 100

# Precarcamos los pipes
onready var PIPE = preload('res://scenes/lvl_3_tuberias/pipe.tscn')

var terrain: Array = [] #lista donde guardamos el terreno

func _ready() -> void:
	terrain = $Path2D.get_children()

func _process(delta: float) -> void:
	# Movemos el terreno:
	for platform in terrain:
		platform.offset += terrain_speed * delta

func _on_Timer_timeout() -> void:
	# Creamos nueva instancia de pipe
	var newPipe = PIPE.instance()
	# Asignamos su posición del spawner
	newPipe.position = $PipeSpawner.position
	# Agregamos el nuevo nodo
	self.add_child_below_node($PipeSpawner,newPipe)
