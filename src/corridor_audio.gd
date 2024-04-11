extends Area3D

@onready var fader:AnimationPlayer = $audio_fader

func _ready():
	body_entered.connect(_on_player_entered)
	body_exited.connect(_on_player_exited)

func _on_player_entered(body):
	if body is Player:
		fader.play("fade_in")
	

func _on_player_exited(body):
	if body is Player:
		fader.play("fade_out")
