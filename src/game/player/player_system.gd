class_name PlayerSystem
extends BaseSystem

var _players: Array[PlayerData] = []
var _current_player_index: int = 0
var _local_player_id: int = 0

signal player_joined(player: PlayerData)
signal player_left(player_id: int)
signal turn_changed(player_id: int)

func _on_initialize() -> void:
	print("PlayerSystem initialized")

func add_player(player: PlayerData) -> bool:
	if _players.size() >= GameManager.MAX_PLAYER_COUNT:
		push_error("Maximum player count reached")
		return false
	
	if get_player_by_id(player.player_id) != null:
		push_error("Player with id %d already exists" % player.player_id)
		return false
	
	_players.append(player)
	player_joined.emit(player)
	print("Player joined: %s (ID: %d)" % [player.player_name, player.player_id])
	return true

func remove_player(player_id: int) -> bool:
	for i: int in range(_players.size()):
		if _players[i].player_id == player_id:
			_players.remove_at(i)
			player_left.emit(player_id)
			return true
	return false

func get_player_by_id(player_id: int) -> PlayerData:
	for player: PlayerData in _players:
		if player.player_id == player_id:
			return player
	return null

func get_player_by_index(index: int) -> PlayerData:
	if index >= 0 and index < _players.size():
		return _players[index]
	return null

func get_current_player() -> PlayerData:
	return get_player_by_index(_current_player_index)

func next_player() -> PlayerData:
	if _players.is_empty():
		return null
	
	_current_player_index = (_current_player_index + 1) % _players.size()
	var player: PlayerData = get_current_player()
	turn_changed.emit(player.player_id)
	return player

func set_current_player(player_id: int) -> bool:
	for i: int in range(_players.size()):
		if _players[i].player_id == player_id:
			_current_player_index = i
			turn_changed.emit(player_id)
			return true
	return false

func get_all_players() -> Array[PlayerData]:
	return _players.duplicate()

func get_player_count() -> int:
	return _players.size()

func set_local_player(player_id: int) -> void:
	_local_player_id = player_id

func get_local_player() -> PlayerData:
	return get_player_by_id(_local_player_id)

func clear_players() -> void:
	_players.clear()
	_current_player_index = 0
