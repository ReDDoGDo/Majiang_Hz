class_name RuleSystem
extends BaseSystem

var _rule_checker: RuleChecker

signal meld_available(meld_type: RuleType.MeldType, tiles: Array)
signal win_available(win_type: RuleType.WinType)

func _on_initialize() -> void:
	_rule_checker = RuleChecker.new()
	print("RuleSystem initialized")

func check_meld_opportunities(hand: Array[TileData], tile: TileData, is_next_player: bool) -> Dictionary:
	var opportunities: Dictionary = {}
	
	if _rule_checker.can_peng(hand, tile):
		opportunities["peng"] = tile
	
	if _rule_checker.can_gang(hand, tile):
		opportunities["gang"] = tile
	
	if _rule_checker.can_chi(hand, tile, is_next_player):
		opportunities["chi"] = tile
	
	var an_gang_tiles: Array[TileData] = _rule_checker.can_an_gang(hand)
	if not an_gang_tiles.is_empty():
		opportunities["an_gang"] = an_gang_tiles
	
	if not opportunities.is_empty():
		for key: String in opportunities:
			var meld_type: RuleType.MeldType
			match key:
				"peng": meld_type = RuleType.MeldType.PENG
				"gang": meld_type = RuleType.MeldType.GANG
				"chi": meld_type = RuleType.MeldType.CHI
				"an_gang": meld_type = RuleType.MeldType.AN_GANG
			
			var tiles: Array
			if key == "an_gang":
				tiles = opportunities[key]
			else:
				tiles = [opportunities[key]]
			
			meld_available.emit(meld_type, tiles)
	
	return opportunities

func check_win_condition(hand: Array[TileData], melds: Array[Array], win_tile: TileData, is_self_draw: bool) -> bool:
	var can_win: bool = _rule_checker.check_win(hand, melds, win_tile)
	
	if can_win:
		var win_type: RuleType.WinType = RuleType.WinType.ZIMO if is_self_draw else RuleType.WinType.DIANPAO
		win_available.emit(win_type)
	
	return can_win

func get_rule_checker() -> RuleChecker:
	return _rule_checker
