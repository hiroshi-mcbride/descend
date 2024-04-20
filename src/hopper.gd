class_name Hopper extends RigidBody3D

@export var animation:String
@onready var animation_player : AnimationPlayer = $AnimationPlayer

func _on_cutscene_start():
	animation_player.play(animation)
	animation_player.animation_finished.connect(_on_animation_finished)


func _on_animation_finished(_anim_name:String):
	apply_central_impulse(Vector3(0, 30, -30))
