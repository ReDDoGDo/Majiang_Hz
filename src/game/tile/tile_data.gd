class_name TileData
extends RefCounted

var tile_type: TileType.Type = TileType.Type.WAN
var value: int = 1
var id: int = 0

func _init(type: TileType.Type = TileType.Type.WAN, tile_value: int = 1, tile_id: int = 0) -> void:
	tile_type = type
	value = tile_value
	id = tile_id

func get_display_name() -> String:
	if TileType.is_number_tile(tile_type):
		return "%d%s" % [value, TileType.get_type_name(tile_type)]
	return TileType.get_type_name(tile_type)

func is_same_type(other: TileData) -> bool:
	return tile_type == other.tile_type

func is_same_value(other: TileData) -> bool:
	return value == other.value

func is_same_tile(other: TileData) -> bool:
	return is_same_type(other) and is_same_value(other)

func duplicate_tile() -> TileData:
	return TileData.new(tile_type, value, id)

func to_dict() -> Dictionary:
	return {
		"type": tile_type,
		"value": value,
		"id": id
	}

static func from_dict(data: Dictionary) -> TileData:
	return TileData.new(data.type, data.value, data.id)
