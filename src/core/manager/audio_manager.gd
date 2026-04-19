extends BaseManager

var _audio_players: Dictionary = {}
var _music_volume: float = 1.0
var _sfx_volume: float = 1.0
var _master_volume: float = 1.0

signal volume_changed(type: String, value: float)

func _on_initialize() -> void:
	print("AudioManager initialized")

func play_music(stream: AudioStream, loop: bool = true) -> void:
	var player: AudioStreamPlayer = _get_or_create_player("music")
	player.stream = stream
	player.volume_db = _linear_to_db(_music_volume * _master_volume)
	player.play()
	
	if loop and stream is AudioStreamOggVorbis or stream is AudioStreamMP3:
		stream.loop = true

func stop_music() -> void:
	if _audio_players.has("music"):
		var player: AudioStreamPlayer = _audio_players["music"]
		player.stop()

func play_sfx(stream: AudioStream) -> void:
	var player: AudioStreamPlayer = AudioStreamPlayer.new()
	player.stream = stream
	player.volume_db = _linear_to_db(_sfx_volume * _master_volume)
	player.finished.connect(_on_sfx_finished.bind(player))
	add_child(player)
	player.play()

func _on_sfx_finished(player: AudioStreamPlayer) -> void:
	player.queue_free()

func set_master_volume(value: float) -> void:
	_master_volume = clamp(value, 0.0, 1.0)
	volume_changed.emit("master", _master_volume)
	_update_all_volumes()

func set_music_volume(value: float) -> void:
	_music_volume = clamp(value, 0.0, 1.0)
	volume_changed.emit("music", _music_volume)
	_update_all_volumes()

func set_sfx_volume(value: float) -> void:
	_sfx_volume = clamp(value, 0.0, 1.0)
	volume_changed.emit("sfx", _sfx_volume)

func get_master_volume() -> float:
	return _master_volume

func get_music_volume() -> float:
	return _music_volume

func get_sfx_volume() -> float:
	return _sfx_volume

func _get_or_create_player(name: String) -> AudioStreamPlayer:
	if not _audio_players.has(name):
		var player: AudioStreamPlayer = AudioStreamPlayer.new()
		add_child(player)
		_audio_players[name] = player
	return _audio_players[name]

func _update_all_volumes() -> void:
	if _audio_players.has("music"):
		var player: AudioStreamPlayer = _audio_players["music"]
		player.volume_db = _linear_to_db(_music_volume * _master_volume)

func _linear_to_db(value: float) -> float:
	if value <= 0.0:
		return -80.0
	return log(value) * 20.0
