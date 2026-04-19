class_name SyncManager
extends BaseSystem

var _sync_data: Dictionary = {}
var _pending_sync: bool = false

signal sync_completed
signal sync_failed

func _on_initialize() -> void:
	print("SyncManager initialized")

func sync_game_state(state: Dictionary) -> void:
	_sync_data = state.duplicate()
	_pending_sync = true
	
	if NetworkManager.is_host():
		NetworkManager.broadcast_data({"type": "game_state", "data": _sync_data})
	else:
		NetworkManager.send_data(1, {"type": "game_state", "data": _sync_data})
	
	_pending_sync = false
	sync_completed.emit()

func receive_sync_data(data: Dictionary) -> void:
	if data.has("type") and data.type == "game_state":
		_sync_data = data.data.duplicate()
		sync_completed.emit()

func get_sync_data() -> Dictionary:
	return _sync_data.duplicate()

func clear_sync_data() -> void:
	_sync_data.clear()
	_pending_sync = false

func is_sync_pending() -> bool:
	return _pending_sync
