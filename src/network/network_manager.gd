extends BaseManager

enum ConnectionState { DISCONNECTED, CONNECTING, CONNECTED, HOSTING }

var _connection_state: ConnectionState = ConnectionState.DISCONNECTED
var _local_player_id: int = 1

signal connection_state_changed(state: ConnectionState)
signal player_connected(player_id: int)
signal player_disconnected(player_id: int)
signal data_received(player_id: int, data: Dictionary)

func _on_initialize() -> void:
	print("NetworkManager initialized")

func host_game(port: int = 7777) -> bool:
	var peer: ENetMultiplayerPeer = ENetMultiplayerPeer.new()
	var error: int = peer.create_server(port, GameManager.MAX_PLAYER_COUNT)
	
	if error != OK:
		push_error("Failed to create server: %d" % error)
		return false
	
	multiplayer.multiplayer_peer = peer
	_set_connection_state(ConnectionState.HOSTING)
	print("Hosting game on port %d" % port)
	return true

func join_game(address: String, port: int = 7777) -> bool:
	var peer: ENetMultiplayerPeer = ENetMultiplayerPeer.new()
	var error: int = peer.create_client(address, port)
	
	if error != OK:
		push_error("Failed to join server: %d" % error)
		return false
	
	multiplayer.multiplayer_peer = peer
	_set_connection_state(ConnectionState.CONNECTING)
	print("Joining game at %s:%d" % [address, port])
	return true

func disconnect_game() -> void:
	multiplayer.multiplayer_peer = null
	_set_connection_state(ConnectionState.DISCONNECTED)
	print("Disconnected from game")

func is_host() -> bool:
	return _connection_state == ConnectionState.HOSTING

func is_network_connected() -> bool:
	return _connection_state in [ConnectionState.CONNECTED, ConnectionState.HOSTING]

func get_connection_state() -> ConnectionState:
	return _connection_state

func send_data(player_id: int, data: Dictionary) -> void:
	if not is_network_connected():
		return
	
	rpc_id(player_id, "_on_data_received", data)

func broadcast_data(data: Dictionary) -> void:
	if not is_network_connected():
		return
	
	rpc("_on_data_received", data)

@rpc("any_peer", "call_remote")
func _on_data_received(data: Dictionary) -> void:
	var sender_id: int = multiplayer.get_remote_sender_id()
	data_received.emit(sender_id, data)

func _set_connection_state(state: ConnectionState) -> void:
	_connection_state = state
	connection_state_changed.emit(state)
