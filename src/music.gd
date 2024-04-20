extends AudioStreamPlayer

@export var corridor : AudioStreamOggVorbis
@export var open : AudioStreamOggVorbis

func _ready():
	GlobalEvent.music_changed.connect(_on_music_change)

func _on_music_change(newsong : String):
	stop()
	if newsong == "corridor":
		stream = corridor
	if newsong == "open":
		stream = open
	play()
