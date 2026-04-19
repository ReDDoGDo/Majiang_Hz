class_name GameConfig
extends Resource

@export var max_rounds: int = 16
@export var base_score: int = 1
@export var enable_hints: bool = true
@export var enable_flowers: bool = true
@export var player_count: int = 4
@export var turn_time_limit: int = 30

func _init() -> void:
	pass

func to_dict() -> Dictionary:
	return {
		"max_rounds": max_rounds,
		"base_score": base_score,
		"enable_hints": enable_hints,
		"enable_flowers": enable_flowers,
		"player_count": player_count,
		"turn_time_limit": turn_time_limit
	}

static func from_dict(data: Dictionary) -> GameConfig:
	var config: GameConfig = GameConfig.new()
	config.max_rounds = data.get("max_rounds", 16)
	config.base_score = data.get("base_score", 1)
	config.enable_hints = data.get("enable_hints", true)
	config.enable_flowers = data.get("enable_flowers", true)
	config.player_count = data.get("player_count", 4)
	config.turn_time_limit = data.get("turn_time_limit", 30)
	return config
