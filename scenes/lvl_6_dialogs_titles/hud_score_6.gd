extends CanvasLayer

# Called when the node enters the scene tree for the first time.
func _ready():
	playAnimation("idle")

func playAnimation(animation: String):
	$AnimationPlayer.play(animation)
