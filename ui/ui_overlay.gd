class_name Overlay extends CanvasLayer
@onready var anim:AnimationPlayer = $AnimationPlayer

func fade_to_black():
	anim.play("fade_to_black")

func fade_from_black():
	anim.play("fade_from_black")
