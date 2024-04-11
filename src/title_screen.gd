class_name TitleScreen extends Node

signal game_started()

func _input(event):
	if event.is_action_pressed("jump"):
		game_started.emit()
