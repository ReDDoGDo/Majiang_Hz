class_name MainMenu
extends BaseUI

@onready var _start_button: Button = $VBoxContainer/StartButton
@onready var _settings_button: Button = $VBoxContainer/SettingsButton
@onready var _quit_button: Button = $VBoxContainer/QuitButton

signal start_game_requested
signal settings_requested
signal quit_requested

func _setup_ui() -> void:
	name = "MainMenu"

func _connect_signals() -> void:
	if _start_button:
		_start_button.pressed.connect(_on_start_pressed)
	if _settings_button:
		_settings_button.pressed.connect(_on_settings_pressed)
	if _quit_button:
		_quit_button.pressed.connect(_on_quit_pressed)

func _on_start_pressed() -> void:
	start_game_requested.emit()

func _on_settings_pressed() -> void:
	settings_requested.emit()

func _on_quit_pressed() -> void:
	quit_requested.emit()
