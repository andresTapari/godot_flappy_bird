extends Node2D

var speed 
var MIN_POS: int = -240
var MAX_POS: int = 200 

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# Cargamos velocidad:
	speed = get_parent().terrain_speed
	randomize()
	
	# Variamos la posicion del grupo de tuberia
	position.y = rand_range(136, 312)
	
	# Variamos ligeramente la posicion de cada tuberia
	$BottomPipe.position.y = clamp($BottomPipe.position.y + rand_range(-30,30), MIN_POS,MAX_POS)
	$TopPipe.position.y = clamp($TopPipe.position.y + rand_range(-30,30),MIN_POS,MAX_POS)

func _process(delta: float) -> void:
	# Movemos la tuberia
	position.x -= speed * delta 


func _on_VisibilityNotifier2D_screen_exited() -> void:
	# Eliminamos la tuberia cuando sale de la pantalla
	self.queue_free()
