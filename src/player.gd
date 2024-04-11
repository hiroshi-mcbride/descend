class_name Player extends CharacterBody3D


@export var mouse_sensitivity : float
@export_range(0.0, 10.0, 0.1) var speed : float

@onready var cam : Camera3D = $player/head/Camera3D
@onready var head : Node3D = $player/head
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")
var look_vector : Vector2

var last_rot_x : float
var last_rot_y : float

func _ready():
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	cam.make_current()

func _physics_process(delta):
	# movement
	var inputVector = Input.get_vector("move_left", "move_right", "move_down", "move_up")
	var dir = basis * Vector3(inputVector.x, 0, -inputVector.y) * speed
	velocity = Vector3(dir.x, velocity.y, dir.z)
	velocity.y -= gravity * delta
	move_and_slide()
	
	# camera rotation
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
		look_vector = event.relative
