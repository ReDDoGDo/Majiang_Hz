class_name TurnSystem
extends BaseSystem

var _current_phase: TurnPhase.Phase = TurnPhase.Phase.DRAW
var _turn_count: int = 0
var _round_count: int = 0

signal phase_changed(phase: TurnPhase.Phase)
signal turn_started(player_id: int)
signal turn_ended(player_id: int)
signal round_started(round_num: int)
signal round_ended(round_num: int)

func _on_initialize() -> void:
	print("TurnSystem initialized")

func start_turn(player_id: int) -> void:
	_turn_count += 1
	turn_started.emit(player_id)
	set_phase(TurnPhase.Phase.DRAW)
	print("Turn %d started for player %d" % [_turn_count, player_id])

func end_turn(player_id: int) -> void:
	turn_ended.emit(player_id)
	print("Turn ended for player %d" % player_id)

func set_phase(phase: TurnPhase.Phase) -> void:
	_current_phase = phase
	phase_changed.emit(phase)
	print("Phase changed to: %s" % TurnPhase.get_phase_name(phase))

func get_current_phase() -> TurnPhase.Phase:
	return _current_phase

func start_round() -> void:
	_round_count += 1
	_turn_count = 0
	round_started.emit(_round_count)
	print("Round %d started" % _round_count)

func end_round() -> void:
	round_ended.emit(_round_count)
	print("Round %d ended" % _round_count)

func get_turn_count() -> int:
	return _turn_count

func get_round_count() -> int:
	return _round_count

func reset() -> void:
	_current_phase = TurnPhase.Phase.DRAW
	_turn_count = 0
	_round_count = 0
