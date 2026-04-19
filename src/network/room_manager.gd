class_name RoomManager
extends BaseSystem

var _room_id: String = ""
var _room_players: Array[int] = []
var _max_players: int = 4

signal room_created(room_id: String)
signal room_joined(room_id: String)
signal room_left(room_id: String)
signal player_joined_room(player_id: int)
signal player_left_room(player_id: int)

func _on_initialize() -> void:
	print("RoomManager initialized")

func create_room() -> String:
	_room_id = _generate_room_id()
	_room_players.clear()
	_max_players = ConfigManager.get_config("network", "max_players", 4)
	
	if NetworkManager.host_game():
		room_created.emit(_room_id)
		return _room_id
	
	return ""

func join_room(room_id: String, address: String, port: int = 7777) -> bool:
	if NetworkManager.join_game(address, port):
		_room_id = room_id
		room_joined.emit(room_id)
		return true
	return false

func leave_room() -> void:
	NetworkManager.disconnect_game()
	_room_players.clear()
	room_left.emit(_room_id)
	_room_id = ""

func add_player_to_room(player_id: int) -> bool:
	if _room_players.size() >= _max_players:
		return false
	
	if _room_players.has(player_id):
		return false
	
	_room_players.append(player_id)
	player_joined_room.emit(player_id)
	return true

func remove_player_from_room(player_id: int) -> bool:
	if _room_players.has(player_id):
		_room_players.erase(player_id)
		player_left_room.emit(player_id)
		return true
	return false

func get_room_players() -> Array[int]:
	return _room_players.duplicate()

func get_player_count() -> int:
	return _room_players.size()

func is_room_full() -> bool:
	return _room_players.size() >= _max_players

func get_room_id() -> String:
	return _room_id

func _generate_room_id() -> String:
	return "%d%d" % [randi_range(1000, 9999), randi_range(1000, 9999)]
