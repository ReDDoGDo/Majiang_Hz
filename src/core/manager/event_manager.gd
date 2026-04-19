extends BaseManager

var _event_handlers: Dictionary = {}

func _on_initialize() -> void:
	print("EventManager initialized")

func subscribe(event_name: String, callback: Callable) -> void:
	if not _event_handlers.has(event_name):
		_event_handlers[event_name] = []
	
	if not _event_handlers[event_name].has(callback):
		_event_handlers[event_name].append(callback)

func unsubscribe(event_name: String, callback: Callable) -> void:
	if _event_handlers.has(event_name):
		_event_handlers[event_name].erase(callback)

func publish(event_name: String, data: Variant = null) -> void:
	if not _event_handlers.has(event_name):
		return
	
	for callback: Callable in _event_handlers[event_name]:
		if data != null:
			callback.call(data)
		else:
			callback.call()

func clear_event(event_name: String) -> void:
	if _event_handlers.has(event_name):
		_event_handlers[event_name].clear()

func clear_all() -> void:
	_event_handlers.clear()
