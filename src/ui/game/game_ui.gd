class_name GameUI
extends BaseUI

@onready var _player_info_container: HBoxContainer = $TopBar/PlayerInfoContainer
@onready var _remaining_tiles_label: Label = $TopBar/RemainingTilesLabel
@onready var _hand_container: HBoxContainer = $BottomBar/HandContainer
@onready var _action_buttons: HBoxContainer = $BottomBar/ActionButtons

signal tile_selected(tile: TileData)
signal action_pressed(action: String)

func _setup_ui() -> void:
	name = "GameUI"

func update_remaining_tiles(count: int) -> void:
	if _remaining_tiles_label:
		_remaining_tiles_label.text = "剩余: %d" % count

func update_player_hand(tiles: Array[TileData]) -> void:
	if _hand_container == null:
		return
	
	for child: Node in _hand_container.get_children():
		child.queue_free()
	
	for tile: TileData in tiles:
		var tile_button: Button = Button.new()
		tile_button.text = tile.get_display_name()
		tile_button.pressed.connect(_on_tile_button_pressed.bind(tile))
		_hand_container.add_child(tile_button)

func show_action_buttons(actions: Array[String]) -> void:
	if _action_buttons == null:
		return
	
	for child: Node in _action_buttons.get_children():
		child.queue_free()
	
	for action: String in actions:
		var action_button: Button = Button.new()
		action_button.text = action
		action_button.pressed.connect(_on_action_button_pressed.bind(action))
		_action_buttons.add_child(action_button)

func hide_action_buttons() -> void:
	if _action_buttons:
		for child: Node in _action_buttons.get_children():
			child.queue_free()

func _on_tile_button_pressed(tile: TileData) -> void:
	tile_selected.emit(tile)

func _on_action_button_pressed(action: String) -> void:
	action_pressed.emit(action)
