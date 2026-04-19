class_name TileSystem
extends BaseSystem

var _tiles: Array[TileData] = []
var _tile_factory: TileFactory

signal tile_drawn(tile: TileData)
signal tile_discarded(tile: TileData)
signal tiles_shuffled

func _on_initialize() -> void:
	_tile_factory = TileFactory.new()
	print("TileSystem initialized")

func create_tile_set(include_bonus: bool = true) -> void:
	_tiles = _tile_factory.create_full_set(include_bonus)
	print("Created tile set with %d tiles" % _tiles.size())

func shuffle_tiles() -> void:
	_tiles = _tile_factory.shuffle_tiles(_tiles)
	tiles_shuffled.emit()
	print("Tiles shuffled")

func draw_tile() -> TileData:
	if _tiles.is_empty():
		push_error("No tiles left to draw")
		return null
	
	var tile: TileData = _tiles.pop_back()
	tile_drawn.emit(tile)
	return tile

func draw_tiles(count: int) -> Array[TileData]:
	var drawn: Array[TileData] = []
	for i: int in range(min(count, _tiles.size())):
		drawn.append(_tiles.pop_back())
	return drawn

func get_remaining_count() -> int:
	return _tiles.size()

func has_tiles() -> bool:
	return not _tiles.is_empty()

func reset() -> void:
	_tiles.clear()
