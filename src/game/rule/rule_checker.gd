class_name RuleChecker
extends RefCounted

func can_peng(hand: Array[TileData], tile: TileData) -> bool:
	var count: int = 0
	for t: TileData in hand:
		if t.is_same_tile(tile):
			count += 1
	return count >= 2

func can_gang(hand: Array[TileData], tile: TileData) -> bool:
	var count: int = 0
	for t: TileData in hand:
		if t.is_same_tile(tile):
			count += 1
	return count >= 3

func can_an_gang(hand: Array[TileData]) -> Array[TileData]:
	var result: Array[TileData] = []
	var counts: Dictionary = {}
	
	for tile: TileData in hand:
		var key: String = "%d_%d" % [tile.tile_type, tile.value]
		if not counts.has(key):
			counts[key] = {"count": 0, "tile": tile}
		counts[key].count += 1
	
	for key: String in counts:
		if counts[key].count >= 4:
			result.append(counts[key].tile)
	
	return result

func can_chi(hand: Array[TileData], tile: TileData, is_next_player: bool) -> bool:
	if not is_next_player:
		return false
	
	if not TileType.is_number_tile(tile.tile_type):
		return false
	
	var has_prev: bool = false
	var has_next: bool = false
	var has_prev_prev: bool = false
	var has_next_next: bool = false
	
	for t: TileData in hand:
		if t.tile_type != tile.tile_type:
			continue
		
		if t.value == tile.value - 1:
			has_prev = true
		elif t.value == tile.value + 1:
			has_next = true
		elif t.value == tile.value - 2:
			has_prev_prev = true
		elif t.value == tile.value + 2:
			has_next_next = true
	
	return (has_prev and has_next) or (has_prev and has_prev_prev) or (has_next and has_next_next)

func check_win(hand: Array[TileData], melds: Array[Array], win_tile: TileData) -> bool:
	var all_tiles: Array[TileData] = []
	all_tiles.assign(hand)
	all_tiles.append(win_tile)
	
	for meld: Array in melds:
		all_tiles.append_array(meld)
	
	return _check_winning_pattern(all_tiles)

func _check_winning_pattern(tiles: Array[TileData]) -> bool:
	if tiles.size() % 3 != 2:
		return false
	
	var sorted: Array[TileData] = []
	sorted.assign(tiles)
	sorted.sort_custom(_compare_tiles)
	
	return _try_find_pairs(sorted, 0, tiles.size() / 3)

func _try_find_pairs(tiles: Array[TileData], start: int, melds_needed: int) -> bool:
	if melds_needed == 0:
		return true
	
	for i: int in range(start, tiles.size() - 1):
		if tiles[i].is_same_tile(tiles[i + 1]):
			var remaining: Array[TileData] = []
			for j: int in range(tiles.size()):
				if j != i and j != i + 1:
					remaining.append(tiles[j])
			
			if _try_find_melds(remaining, melds_needed):
				return true
	
	return false

func _try_find_melds(tiles: Array[TileData], melds_needed: int) -> bool:
	if melds_needed == 0:
		return tiles.is_empty()
	
	if tiles.size() < 3:
		return false
	
	if _try_pong(tiles, melds_needed):
		return true
	
	if _try_sequence(tiles, melds_needed):
		return true
	
	return false

func _try_pong(tiles: Array[TileData], melds_needed: int) -> bool:
	for i: int in range(tiles.size() - 2):
		if tiles[i].is_same_tile(tiles[i + 1]) and tiles[i].is_same_tile(tiles[i + 2]):
			var remaining: Array[TileData] = []
			for j: int in range(tiles.size()):
				if j < i or j > i + 2:
					remaining.append(tiles[j])
			return _try_find_melds(remaining, melds_needed - 1)
	return false

func _try_sequence(tiles: Array[TileData], melds_needed: int) -> bool:
	for i: int in range(tiles.size()):
		if not TileType.is_number_tile(tiles[i].tile_type):
			continue
		
		var tile1: TileData = tiles[i]
		var tile2: TileData = null
		var tile3: TileData = null
		
		for j: int in range(tiles.size()):
			if j != i and tiles[j].tile_type == tile1.tile_type and tiles[j].value == tile1.value + 1:
				tile2 = tiles[j]
				break
		
		if tile2 == null:
			continue
		
		for j: int in range(tiles.size()):
			if j != i and tiles[j] != tile2 and tiles[j].tile_type == tile1.tile_type and tiles[j].value == tile1.value + 2:
				tile3 = tiles[j]
				break
		
		if tile3 == null:
			continue
		
		var remaining: Array[TileData] = []
		for j: int in range(tiles.size()):
			if tiles[j] != tile1 and tiles[j] != tile2 and tiles[j] != tile3:
				remaining.append(tiles[j])
		return _try_find_melds(remaining, melds_needed - 1)
	
	return false

func _compare_tiles(a: TileData, b: TileData) -> bool:
	if a.tile_type != b.tile_type:
		return a.tile_type < b.tile_type
	return a.value < b.value
