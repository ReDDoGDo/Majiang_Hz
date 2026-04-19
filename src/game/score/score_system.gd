class_name ScoreSystem
extends BaseSystem

var _calculator: ScoreCalculator
var _scores: Dictionary = {}

signal score_updated(player_id: int, new_score: int)
signal score_transferred(from_id: int, to_id: int, amount: int)

func _on_initialize() -> void:
	_calculator = ScoreCalculator.new()
	print("ScoreSystem initialized")

func initialize_player_score(player_id: int, initial_score: int = 0) -> void:
	_scores[player_id] = initial_score
	score_updated.emit(player_id, initial_score)

func get_player_score(player_id: int) -> int:
	if _scores.has(player_id):
		return _scores[player_id]
	return 0

func add_score(player_id: int, amount: int) -> void:
	if not _scores.has(player_id):
		_scores[player_id] = 0
	
	_scores[player_id] += amount
	score_updated.emit(player_id, _scores[player_id])

func subtract_score(player_id: int, amount: int) -> bool:
	if not _scores.has(player_id):
		return false
	
	if _scores[player_id] < amount:
		return false
	
	_scores[player_id] -= amount
	score_updated.emit(player_id, _scores[player_id])
	return true

func transfer_score(from_id: int, to_id: int, amount: int) -> bool:
	if subtract_score(from_id, amount):
		add_score(to_id, amount)
		score_transferred.emit(from_id, to_id, amount)
		return true
	return false

func calculate_win_score(
	winner_id: int,
	win_type: RuleType.WinType,
	hand: Array[TileData],
	melds: Array[Array],
	win_tile: TileData,
	is_dealer: bool,
	is_gang_win: bool = false
) -> int:
	var fan: int = _calculator.calculate_fan(hand, melds, win_tile)
	var score: int = _calculator.calculate_score(win_type, is_dealer, fan, is_gang_win)
	return score

func apply_win_result(
	winner_id: int,
	loser_id: int,
	win_type: RuleType.WinType,
	hand: Array[TileData],
	melds: Array[Array],
	win_tile: TileData,
	is_dealer: bool,
	is_gang_win: bool = false
) -> int:
	var score: int = calculate_win_score(winner_id, win_type, hand, melds, win_tile, is_dealer, is_gang_win)
	
	if win_type == RuleType.WinType.ZIMO:
		for player_id: int in _scores.keys():
			if player_id != winner_id:
				transfer_score(player_id, winner_id, score)
	else:
		transfer_score(loser_id, winner_id, score)
	
	return score

func get_all_scores() -> Dictionary:
	return _scores.duplicate()

func reset_scores() -> void:
	_scores.clear()
