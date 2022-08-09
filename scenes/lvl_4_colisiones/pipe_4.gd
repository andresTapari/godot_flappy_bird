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

# Funciones:
func check_player_hit(body,type):
	# Si el cuerpo forma parte del grupo player:
	if body.is_in_group("player"):
		# Si el tipo es pipe:
		if type == "pipe":
			# Llamamos a la funcion hit de player
			body.hit()
		# si el tipo es score:
		elif type == "score":
			# Llamamos a la funcion score de player:
			body.score()
		# si esta mal escrito el tipo:
		else:
			# Mostramos en pantalla que esta mal el tipo
			print_debug("WARNING: Unsuported type:",type)

# Señales:
func _on_VisibilityNotifier2D_screen_exited() -> void:
	# Eliminamos la tuberia cuando sale de la pantalla
	self.queue_free()

func _on_BottomPipe_body_entered(body):
	check_player_hit(body,'pipe')

func _on_TopPipe_body_entered(body):
	check_player_hit(body,'pipe')

func _on_CheckPointArea_body_entered(body):
	check_player_hit(body,'score')
