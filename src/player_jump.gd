extends Node3D

@onready var trigger : Area3D = $Area3D
@onready var collider : CollisionShape3D = $StaticBody3D/CollisionShape3D
@onready var press_jump : PressJump = $"../press_jump"
@onready var timer : Timer = $Timer

signal player_jumped
var is_player_inside
var has_jumped = false

func _ready():
	timer.timeout.connect(GlobalEvent._on_player_fallen)

func _on_player_entered(body):
	if body is Player:
		is_player_inside = true
		press_jump.fade_in()

func _on_player_exited(body):
	if body is Player:
		is_player_inside = false
		press_jump.fade_out()

func _input(event):
	if event.is_action_pressed("jump") and is_player_inside and not has_jumped:
		timer.start()
		collider.disabled = true
		player_jumped.emit()
		has_jumped = true
		press_jump.fade_out()

