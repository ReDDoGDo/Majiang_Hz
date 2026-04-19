class_name ResultUI
extends BaseUI

@onready var _winner_label: Label = $VBoxContainer/WinnerLabel
@onready var _score_container: VBoxContainer = $VBoxContainer/ScoreContainer
@onready var _continue_button: Button = $VBoxContainer/ContinueButton

signal continue_requested

func _setup_ui() -> void:
	name = "ResultUI"

func _connect_signals() -> void:
	if _continue_button:
		_continue_button.pressed.connect(_on_continue_pressed)

func display_result(winner_name: String, scores: Dictionary) -> void:
	if _winner_label:
		_winner_label.text = "赢家: %s" % winner_name
	
	if _score_container:
		for child: Node in _score_container.get_children():
			child.queue_free()
		
		for player_id: Variant in scores:
			var score_label: Label = Label.new()
			score_label.text = "玩家 %d: %d 分" % [player_id, scores[player_id]]
			_score_container.add_child(score_label)

func _on_continue_pressed() -> void:
	continue_requested.emit()
