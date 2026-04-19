class_name ScoreCalculator
extends RefCounted

const BASE_SCORE: int = 1
const ZIMO_MULTIPLIER: int = 2
const GANG_MULTIPLIER: int = 2
const DEALER_MULTIPLIER: int = 2

var _fan_rules: Dictionary = {
	"pinghu": 1,
	"duiduihu": 2,
	"qingyise": 4,
	"zimo": 1,
	"gangshangkaihua": 2,
	"qianggang": 2
}

func calculate_score(
	win_type: RuleType.WinType,
	is_dealer: bool,
	fan_count: int,
	is_gang_win: bool = false
) -> int:
	var score: int = BASE_SCORE
	
	score *= fan_count
	
	if win_type == RuleType.WinType.ZIMO:
		score *= ZIMO_MULTIPLIER
	
	if is_gang_win:
		score *= GANG_MULTIPLIER
	
	if is_dealer:
		score *= DEALER_MULTIPLIER
	
	return score

func calculate_fan(hand: Array[TileData], melds: Array[Array], win_tile: TileData) -> int:
	var fan: int = 1
	
	if _check_qingyise(hand, melds):
		fan += _fan_rules["qingyise"]
	
	if _check_duiduihu(hand, melds):
		fan += _fan_rules["duiduihu"]
	
	return fan

func _check_qingyise(hand: Array[TileData], melds: Array[Array]) -> bool:
	var types: Array = []
	
	for tile: TileData in hand:
		if not types.has(tile.tile_type):
			types.append(tile.tile_type)
	
	for meld: Array in melds:
		for tile: TileData in meld:
			if not types.has(tile.tile_type):
				types.append(tile.tile_type)
	
	return types.size() == 1 and TileType.is_number_tile(types[0])

func _check_duiduihu(hand: Array[TileData], melds: Array[Array]) -> bool:
	var counts: Dictionary = {}
	
	for tile: TileData in hand:
		var key: String = "%d_%d" % [tile.tile_type, tile.value]
		if not counts.has(key):
			counts[key] = 0
		counts[key] += 1
	
	for count: int in counts.values():
		if count != 2 and count != 3 and count != 4:
			return false
	
	for meld: Array in melds:
		if meld.size() == 3:
			if not meld[0].is_same_tile(meld[1]):
				return false
	
	return true

func get_fan_rules() -> Dictionary:
	return _fan_rules.duplicate()
