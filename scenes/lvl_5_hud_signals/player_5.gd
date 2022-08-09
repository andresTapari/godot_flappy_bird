extends KinematicBody2D

# Señales:
signal update_score
signal game_start
signal game_over

# Variables :
export var gravity: float 		= 650	
export var jump_speed: float 	= 250

# Variables locales:
var velocity: Vector2 = Vector2.ZERO
var state_started: bool = false			# Bandera si la partida comenzo
var state_knok_down: bool = false		# Bandera si el jugador fue knokeado

func _process(delta: float) -> void:
	# Detectamos tecla de salto
	if Input.is_action_just_pressed('jump') and state_knok_down == false:
		# Si el jugador no habia comenzado
		if !state_started:
			emit_signal('game_start')
			# Buscamos el timer del nivel, y lo iniciamos
			get_parent().get_node("Timer").start()
			# Establecemos la variable de comienzo como verdadero
			state_started = true
		
		# Si hay un salto establecemos que el movimiento 
		# en y es la velocidad de salto
		velocity.y = -jump_speed
		$AnimatedSprite.rotation_degrees = -30

	
	# Rotamos el personaje:
	var sprite_rotation = lerp_angle(deg2rad(-30),deg2rad(90),velocity.y/10)
	$AnimatedSprite.rotation_degrees = clamp(sprite_rotation,-30,90)

	# Movemos el personaje:
	if state_started and !is_on_floor():
		# Si el jugador comenzo la partida:
		# Aplicamos gravedad:
		velocity.y += (velocity.y + gravity)  * delta
		# warning-ignore:RETURN_VALUE_DISCARDED
		move_and_slide(velocity, Vector2.UP)

	if is_on_floor():
		# Si esta en el piso, llamamos a hit
		hit()

func hit() -> void:
	if state_knok_down:
		return
	# emitir señal de game over:
	emit_signal('game_over')
	# detenemos animacion
	$AnimatedSprite.stop()
	# detenemos el juego
	get_parent().stop_game()
	# establecemos fin del juego
	state_knok_down = true

func score() -> void:
	# sumamos un punto en el puntaje
	get_parent().score += 1
	# enviamos señal
	emit_signal('update_score')
	# mostramos en consola el puntaje
	print_debug(get_parent().score)
