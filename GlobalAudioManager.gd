extends Node
class_name AudioManager

@export var default_music_volume_db: float = -10.0
@export var default_sfx_volume_db: float = -5.0

var _music_player: AudioStreamPlayer
var _sfx_players: Array[AudioStreamPlayer] = []
const MAX_SFX_PLAYERS = 10  

func _ready():
	_music_player = AudioStreamPlayer.new()
	_music_player.bus = "Music"
	add_child(_music_player)
	
	for i in range(MAX_SFX_PLAYERS):  # ← Aquí el cambio importante
		var player = AudioStreamPlayer.new()
		player.bus = "SFX"
		add_child(player)
		_sfx_players.append(player)

	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Music"), default_music_volume_db)
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("SFX"), default_sfx_volume_db)

func play_music(stream: AudioStream):
	_music_player.stream = stream
	_music_player.finished.connect(_on_music_finished, CONNECT_ONE_SHOT)
	_music_player.play()

func _on_music_finished():
	if _music_player.stream:  
		play_music(_music_player.stream)

func stop_music():
	_sfx_players.clear()

func set_music_volume(volume_db: float):
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Music"), volume_db)

func toggle_music():
	if _music_player.playing:
		_music_player.stop()
	else:
		_music_player.play()

func play_sfx(stream: AudioStream, pitch_variation: float = 0.0):
	if stream == null:
		push_error("AudioManager: Stream de SFX inválido")
		return
	
	var available_player = _get_available_sfx_player()
	if available_player:
		available_player.stream = stream.duplicate()
		available_player.pitch_scale = 1.0 + randf_range(-pitch_variation, pitch_variation)
		available_player.play()
	else:
		var temp = AudioStreamPlayer.new()
		temp.bus = "SFX"
		temp.stream = stream.duplicate()
		temp.pitch_scale = 1.0 + randf_range(-pitch_variation, pitch_variation)
		temp.finished.connect(temp.queue_free)
		add_child(temp)
		temp.play()


func set_sfx_volume(volume_db: float):
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("SFX"), volume_db)


func _get_available_sfx_player() -> AudioStreamPlayer:
	for player in _sfx_players:
		if not player.playing:
			return player
	push_warning("AudioManager: Todos los SFX players están en uso")
	return null  

func mute_all(mute: bool):
	AudioServer.set_bus_mute(AudioServer.get_bus_index("Master"), mute)
	
func stop_specific_music(stream_to_stop: AudioStream):
	if _music_player.stream == stream_to_stop and _music_player.playing:
		_music_player.stop()
		
func unmute_all():
	AudioServer.set_bus_mute(AudioServer.get_bus_index("Master"), false)
