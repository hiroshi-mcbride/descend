extends Node3D

const TITLESCREEN = preload("res://levels/titlescreen.tscn")
const LEVEL = preload("res://levels/level.tscn")
const UI_OVERLAY = preload("res://ui/ui_overlay.tscn")

var current_level : Node
var overlay : Overlay


func _enter_tree():
	
	current_level = TITLESCREEN.instantiate()
	add_child(current_level)
	assert(current_level is TitleScreen)
	
	overlay = UI_OVERLAY.instantiate()
	add_child(overlay)
	assert(overlay is Overlay)
	await overlay.ready
	overlay.fade_from_black()
	
	current_level.game_started.connect(_on_game_started)

func _input(event):
	if event.is_action_pressed("ui_cancel"):
		get_tree().quit()

func _on_game_started():
	overlay.fade_to_black()
	await overlay.anim.animation_finished
	current_level.queue_free()
	await current_level.tree_exited
	current_level = LEVEL.instantiate()
	add_child(current_level)
	move_child(current_level, 0)
	overlay.fade_from_black()
	GlobalEvent.game_ended.connect(_on_game_end)


func _on_game_end():
	GlobalEvent.game_ended.disconnect(_on_game_end)
	overlay.fade_to_black()
	await overlay.anim.animation_finished
	current_level.queue_free()
	await current_level.tree_exited
	GlobalEvent.music_changed.emit("corridor")
	current_level = TITLESCREEN.instantiate()
	add_child(current_level)
	move_child(current_level, 0)
	overlay.fade_from_black()
	current_level.game_started.connect(_on_game_started)
