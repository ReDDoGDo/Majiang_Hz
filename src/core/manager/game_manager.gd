extends BaseManager

const MAX_PLAYER_COUNT: int = 4
const MIN_PLAYER_COUNT: int = 2

var _current_player_count: int = 4
var _game_state: String = "idle"

signal game_started
signal game_ended
signal game_paused
signal game_resumed
signal state_changed(new_state: String)

func _on_initialize() -> void:
	print("GameManager initialized")

func start_game(player_count: int = 4) -> void:
	if player_count < MIN_PLAYER_COUNT or player_count > MAX_PLAYER_COUNT:
		push_error("Invalid player count: %d" % player_count)
		return
	
	_current_player_count = player_count
	_set_state("playing")
	game_started.emit()
	print("Game started with %d players" % player_count)

func end_game() -> void:
	_set_state("ended")
	game_ended.emit()
	print("Game ended")

func pause_game() -> void:
	if _game_state != "playing":
		return
	_set_state("paused")
	game_paused.emit()

func resume_game() -> void:
	if _game_state != "paused":
		return
	_set_state("playing")
	game_resumed.emit()

func _set_state(new_state: String) -> void:
	var old_state: String = _game_state
	_game_state = new_state
	state_changed.emit(new_state)
	print("Game state changed: %s -> %s" % [old_state, new_state])

func get_game_state() -> String:
	return _game_state

func get_player_count() -> int:
	return _current_player_count
