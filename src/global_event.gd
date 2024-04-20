extends Node

signal game_ended()
signal music_changed(newsong : String)

func _on_player_fallen():
	game_ended.emit()
