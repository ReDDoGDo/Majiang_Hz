class_name PlayerData
extends RefCounted

var player_id: int = 0
var player_name: String = ""
var is_local: bool = true
var is_ready: bool = false

var hand_tiles: Array[TileData] = []
var melded_tiles: Array[Array] = []
var discarded_tiles: Array[TileData] = []
var flower_tiles: Array[TileData] = []

var score: int = 0
var is_dealer: bool = false
var is_online: bool = true

func _init(id: int = 0, name: String = "") -> void:
	player_id = id
	player_name = name

func add_tile(tile: TileData) -> void:
	hand_tiles.append(tile)

func remove_tile(tile: TileData) -> bool:
	for i: int in range(hand_tiles.size()):
		if hand_tiles[i].id == tile.id:
			hand_tiles.remove_at(i)
			return true
	return false

func discard_tile(tile: TileData) -> bool:
	if remove_tile(tile):
		discarded_tiles.append(tile)
		return true
	return false

func add_meld(tiles: Array[TileData]) -> void:
	melded_tiles.append(tiles)

func add_flower(tile: TileData) -> void:
	flower_tiles.append(tile)

func get_hand_count() -> int:
	return hand_tiles.size()

func get_discarded_count() -> int:
	return discarded_tiles.size()

func sort_hand() -> void:
	hand_tiles.sort_custom(_compare_tiles)

func _compare_tiles(a: TileData, b: TileData) -> bool:
	if a.tile_type != b.tile_type:
		return a.tile_type < b.tile_type
	return a.value < b.value

func clear_hand() -> void:
	hand_tiles.clear()
	melded_tiles.clear()
	discarded_tiles.clear()
	flower_tiles.clear()

func to_dict() -> Dictionary:
	return {
		"player_id": player_id,
		"player_name": player_name,
		"is_local": is_local,
		"score": score,
		"is_dealer": is_dealer
	}
