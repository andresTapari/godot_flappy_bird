extends KinematicBody2D

# Variables :
export var gravity: float 		= 650
export var jump_speed: float 	= 250

# Variables locales:
var velocity: Vector2 = Vector2.ZERO

func _process(delta: float) -> void:
	# Detectamos tecla de salto
	if Input.is_action_just_pressed('ui_up'):
		# Si hay un salto establecemos que el movimiento 
		# en y es la velocidad de salto
		velocity.y = -jump_speed
		$AnimatedSprite.rotation_degrees = -45

	# Aplicamos gravedad:
	velocity.y += (velocity.y + gravity)  * delta

	# Rotamos el personaje:
	var sprite_rotation = lerp_angle(deg2rad(-45),deg2rad(90),velocity.y/10)
	$AnimatedSprite.rotation_degrees = clamp(sprite_rotation,-45,90)

	# Movemos el personaje:
	# warning-ignore:RETURN_VALUE_DISCARDED
	move_and_slide(velocity, Vector2.UP)
