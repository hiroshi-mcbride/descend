class_name Player extends CharacterBody3D

enum InputState { DISABLED, GAMEPAD, MKB }
@export var mouse_sensitivity : float
@export_range(0.0, 10.0, 0.1) var speed : float

@onready var head : Node3D = $player/head
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")
var look_vector : Vector2

var last_rot_x : float
var last_rot_y : float
var input_state : InputState = InputState.MKB

func _ready():
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

func _physics_process(delta):
	if input_state == InputState.DISABLED:
		velocity.y -= gravity * delta
		velocity.z = lerpf(velocity.z, 0, delta)
		move_and_slide()
	else:
		# movement
		var move_vector = Input.get_vector("move_left", "move_right", "move_up", "move_down")
		var dir = basis * Vector3(move_vector.x, 0, move_vector.y) * speed
		velocity = Vector3(dir.x, velocity.y, dir.z)
		velocity.y -= gravity * delta
		move_and_slide()
	
	# camera rotation
	
	var gamepad_look = Input.get_vector("look_left", "look_right", "look_up", "look_down") * 25
	if gamepad_look.length_squared() > 0:
		input_state = InputState.GAMEPAD
		look_vector = gamepad_look
	var rot_x = head.rotation.x - look_vector.y * delta
	rot_x = clampf(rot_x, -PI*0.4, PI*0.49)
	rot_x -= head.rotation.x
	rot_x *= mouse_sensitivity
	
	var rot_y = -look_vector.x * mouse_sensitivity * delta
	
	head.rotate_object_local(Vector3(1,0,0), lerpf(0, rot_x, 0.2))
	rotate_object_local(Vector3(0,1,0),lerpf(0, rot_y, 0.2))
	
	look_vector = Vector2.ZERO

func _input(event):
	
	if event is InputEventMouseMotion:
		# modify accumulated mouse rotation
		#print_debug("event is registering")
		if input_state != InputState.DISABLED:
			input_state = InputState.MKB
		look_vector = event.relative


func _on_player_jumped():
	input_state = InputState.DISABLED
	velocity = Vector3(0, 10, -15)
