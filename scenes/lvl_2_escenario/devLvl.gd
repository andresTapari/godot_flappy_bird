extends Node2D

export var terrain_speed = 100

var terrain: Array = [] #lista donde guardamos los nodos

func _ready() -> void:
	terrain = $Path2D.get_children()

func _process(delta: float) -> void:
	for platform in terrain:
		platform.offset += terrain_speed * delta
