extends BaseManager

const CONFIG_PATH: String = "res://resources/config/game_config.tres"

var _config: Dictionary = {
	"game": {
		"max_rounds": 16,
		"base_score": 1,
		"enable_hints": true
	},
	"audio": {
		"master_volume": 1.0,
		"music_volume": 0.8,
		"sfx_volume": 1.0
	},
	"display": {
		"fullscreen": false,
		"vsync": true,
		"resolution_scale": 1.0
	},
	"network": {
		"default_port": 7777,
		"max_players": 4
	}
}

func _on_initialize() -> void:
	print("ConfigManager initialized")
	_load_config()

func _load_config() -> void:
	if ResourceLoader.exists(CONFIG_PATH):
		var resource: Resource = load(CONFIG_PATH)
		if resource is GameConfig:
			_apply_config_resource(resource)

func _apply_config_resource(resource: GameConfig) -> void:
	_config["game"]["max_rounds"] = resource.max_rounds
	_config["game"]["base_score"] = resource.base_score
	_config["game"]["enable_hints"] = resource.enable_hints

func get_config(section: String, key: String, default: Variant = null) -> Variant:
	if _config.has(section) and _config[section].has(key):
		return _config[section][key]
	return default

func set_config(section: String, key: String, value: Variant) -> void:
	if not _config.has(section):
		_config[section] = {}
	_config[section][key] = value

func get_section(section: String) -> Dictionary:
	if _config.has(section):
		return _config[section].duplicate()
	return {}

func save_config() -> bool:
	return true
