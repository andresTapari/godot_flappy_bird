# devlvl_7.gd
extends Node2D

# Variables de exportacion
export var terrain_speed = 100

# Precarcamos los nodos base:
onready var PIPE = preload("res://scenes/lvl_4_colisiones/pipe_4.tscn")
onready var NAMEDIALOG = preload('res://scenes/lvl_6_dialogs_titles/ui_dialogs/ui_name_entry_dialog.tscn')

# Cargamos nodos del hud
onready var hud_score_label = get_node("hud/score_label")
onready var hud  = get_node("hud")
onready var player := $Player_7
#onready var hud_score_panel	= get_node("hud_score_6/score_panel")

export var score: int = 0		# Puntaje del jugador
var highScore: int = 0			# Puntaje maximo de todos los jugadores

var terrain: Array = [] 		# Lista donde guardamos el terreno
var game_state: bool = true		#

func _ready() -> void:
	SCORE.currentScore = score
	# Cargamos los nodos del terreno
	terrain = $Path2D.get_children()
	# Conectamos las señales del jugador
	
	#warning-ignore: RETURN_VALUE_DISCARDED
	player.connect('update_score',self,'_update_score')
	#warning-ignore: RETURN_VALUE_DISCARDED
	player.connect('game_over',self,'_game_over_screen')
	#warning-ignore: RETURN_VALUE_DISCARDED
	player.connect('game_start',self,'_game_start')

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

func play_sound(media: String) -> void:
	match media:
		'die':
			$AudioStreamPlayer.stream = load("res://assets/flappy-bird-assets-master/audio/die.wav")
		'hit':
			$AudioStreamPlayer.stream = load("res://assets/flappy-bird-assets-master/audio/hit.wav")
		'point':
			$AudioStreamPlayer.stream = load("res://assets/flappy-bird-assets-master/audio/point.wav")
		'swoosh':
			$AudioStreamPlayer.stream = load("res://assets/flappy-bird-assets-master/audio/swoosh.wav")
		'wing':
			$AudioStreamPlayer.stream = load("res://assets/flappy-bird-assets-master/audio/wing.wav")
	if !media.empty():
		$AudioStreamPlayer.play()

# Señales:
func _on_Timer_timeout() -> void:
	# Creamos nueva instancia de pipe
	var newPipe = PIPE.instance()
	# Asignamos su posición del spawner
	newPipe.position = $PipeSpawner.position
	# Agregamos el nuevo nodo por debajo del spawner
	self.add_child_below_node($PipeSpawner,newPipe)

func _update_score() -> void:
	#hud_score_label.text = String(score)
	SCORE.currentScore = score
	hud.updateScore(String(score))
	# Reproducimos sonido:
	play_sound('point')

func _game_over_screen()-> void:
	# Reproducimos sonido:
	play_sound('hit')
	# Reproducimos animacion de Game Over:
	hud.playAnimation("game_over")
	# Esperamos a que termine:
	yield(hud.get_node('AnimationPlayer'),'animation_finished')
	# Si el puntaje es mayor que el minimo del tablero de posiciones
	if score > SCORE.getMinimumScore():
		# Creamos la ventana de dialogo solicitando nombre
		hud.nameDialogFadeIn()
	else:
		# Creamos la ventana de dialogo mostrando puntaje
		hud.scorePanelFadeIn()
	
func _game_start() -> void:
	hud.playAnimation("info_fade_away")

func _on_AudioStreamPlayer_finished():
	$AudioStreamPlayer.stop()
