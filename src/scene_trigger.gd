class_name CutsceneTrigger extends Area3D

signal cutscene_start()

func _ready():
	body_entered.connect(_on_area_body_entered)

func _on_area_body_entered(body):
	if body is Player:
		cutscene_start.emit()
		body_entered.disconnect(_on_area_body_entered)