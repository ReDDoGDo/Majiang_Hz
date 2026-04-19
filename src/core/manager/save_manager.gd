extends BaseManager

const SAVE_PATH: String = "user://save_data.json"

var _save_data: Dictionary = {}

func _on_initialize() -> void:
	print("SaveManager initialized")
	load_game()

func save_game() -> bool:
	var file: FileAccess = FileAccess.open(SAVE_PATH, FileAccess.WRITE)
	if file == null:
		push_error("Failed to open save file: %s" % SAVE_PATH)
		return false
	
	var json_string: String = JSON.stringify(_save_data)
	file.store_string(json_string)
	file.close()
	return true

func load_game() -> bool:
	if not FileAccess.file_exists(SAVE_PATH):
		return false
	
	var file: FileAccess = FileAccess.open(SAVE_PATH, FileAccess.READ)
	if file == null:
		push_error("Failed to open save file: %s" % SAVE_PATH)
		return false
	
	var json_string: String = file.get_as_text()
	file.close()
	
	var json: JSON = JSON.new()
	var error: int = json.parse(json_string)
	if error != OK:
		push_error("Failed to parse save data")
		return false
	
	_save_data = json.data
	return true

func set_value(key: String, value: Variant) -> void:
	_save_data[key] = value

func get_value(key: String, default: Variant = null) -> Variant:
	if _save_data.has(key):
		return _save_data[key]
	return default

func has_key(key: String) -> bool:
	return _save_data.has(key)

func delete_key(key: String) -> void:
	_save_data.erase(key)

func clear_all() -> void:
	_save_data.clear()
