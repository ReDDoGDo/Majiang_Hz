class_name TileFactory
extends RefCounted

const TILE_COUNT_PER_TYPE: int = 4
const NUMBER_TILE_MIN: int = 1
const NUMBER_TILE_MAX: int = 9

var _tile_id_counter: int = 0

func create_full_set(include_bonus: bool = true) -> Array[TileData]:
	var tiles: Array[TileData] = []
	_tile_id_counter = 0
	
	_create_number_tiles(tiles, TileType.Type.WAN)
	_create_number_tiles(tiles, TileType.Type.TIAO)
	_create_number_tiles(tiles, TileType.Type.TONG)
	_create_honor_tiles(tiles)
	
	if include_bonus:
		_create_bonus_tiles(tiles, TileType.Type.FLOWER)
		_create_bonus_tiles(tiles, TileType.Type.SEASON)
	
	return tiles

func _create_number_tiles(tiles: Array[TileData], type: TileType.Type) -> void:
	for value: int in range(NUMBER_TILE_MIN, NUMBER_TILE_MAX + 1):
		for i: int in range(TILE_COUNT_PER_TYPE):
			tiles.append(TileData.new(type, value, _get_next_id()))

func _create_honor_tiles(tiles: Array[TileData]) -> void:
	for value: int in range(1, 5):
		for i: int in range(TILE_COUNT_PER_TYPE):
			tiles.append(TileData.new(TileType.Type.FENG, value, _get_next_id()))
	
	for value: int in range(1, 4):
		for i: int in range(TILE_COUNT_PER_TYPE):
			tiles.append(TileData.new(TileType.Type.ARROW, value, _get_next_id()))

func _create_bonus_tiles(tiles: Array[TileData], type: TileType.Type) -> void:
	for value: int in range(1, 5):
		tiles.append(TileData.new(type, value, _get_next_id()))

func _get_next_id() -> int:
	_tile_id_counter += 1
	return _tile_id_counter

func shuffle_tiles(tiles: Array[TileData]) -> Array[TileData]:
	var result: Array[TileData] = []
	result.assign(tiles)
	result.shuffle()
	return result
