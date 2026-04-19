class_name GameData
extends RefCounted

var game_id: String = ""
var round_number: int = 0
var turn_number: int = 0
var dealer_id: int = 0
var current_player_id: int = 0
var remaining_tiles: int = 0

var player_states: Dictionary = {}
var game_history: Array[Dictionary] = []

func _init() -> void:
	game_id = _generate_game_id()

func set_player_state(player_id: int, state: Dictionary) -> void:
	player_states[player_id] = state

func get_player_state(player_id: int) -> Dictionary:
	if player_states.has(player_id):
		return player_states[player_id]
	return {}

func add_history_entry(entry: Dictionary) -> void:
	game_history.append(entry)

func get_history() -> Array[Dictionary]:
	return game_history.duplicate()

func to_dict() -> Dictionary:
	return {
		"game_id": game_id,
		"round_number": round_number,
		"turn_number": turn_number,
		"dealer_id": dealer_id,
		"current_player_id": current_player_id,
		"remaining_tiles": remaining_tiles,
		"player_states": player_states.duplicate(),
		"game_history": game_history.duplicate()
	}

static func from_dict(data: Dictionary) -> GameData:
	var game_data: GameData = GameData.new()
	game_data.game_id = data.game_id
	game_data.round_number = data.round_number
	game_data.turn_number = data.turn_number
	game_data.dealer_id = data.dealer_id
	game_data.current_player_id = data.current_player_id
	game_data.remaining_tiles = data.remaining_tiles
	game_data.player_states = data.player_states.duplicate()
	game_data.game_history = data.game_history.duplicate()
	return game_data

func _generate_game_id() -> String:
	return "%d_%d" % [Time.get_unix_time_from_system(), randi()]
