extends CharacterBody3D

@onready var head : Node3D = get_node("feller2/head")
var look_vector : Vector2

func _physics_process(delta):
	var inputVector = Input.get_vector("move_left", "move_right", "move_down", "move_up")
	var dir = basis * Vector3(inputVector.x, 0, -inputVector.y)
	velocity = dir * 10
	move_and_slide()
	var rot_x = head.rotation.x - look_vector.y * delta
	rot_x = clampf(rot_x, -PI*0.4, PI*0.49)
	rot_x -= head.rotation.x
	head.rotate_object_local(Vector3(1,0,0), rot_x)
	rotate_object_local(Vector3(0,1,0),-look_vector.x * delta)
	look_vector = Vector2.ZERO

func _unhandled_input(event):
	if event is InputEventMouseMotion:
		# modify accumulated mouse rotation
		look_vector = event.relative
