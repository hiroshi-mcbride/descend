extends Area3D

func _ready():
	body_entered.connect(_on_area_body_entered)

func _on_area_body_entered(body):
	if body is Player:
		GlobalEvent.music_changed.emit("open")
		body_entered.disconnect(_on_area_body_entered)
		queue_free()
