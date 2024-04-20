class_name PressJump extends CanvasLayer
@onready var anim:AnimationPlayer = $AnimationPlayer

var active = false

func fade_in():
	if not active:
		active = true
		anim.play("fade_in")


func fade_out():
	if active:
		active = false
		anim.play("fade_out")
