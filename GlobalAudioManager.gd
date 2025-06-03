extends Node

var player: AudioStreamPlayer

func _ready():
	player = AudioStreamPlayer.new()
	add_child(player)

func play(stream: AudioStream):
	player.stream = stream
	player.play()
	
func stop():
	if player.playing:
		player.stop()
