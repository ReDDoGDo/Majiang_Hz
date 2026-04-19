class_name SettingsUI
extends BaseUI

@onready var _master_slider: HSlider = $VBoxContainer/MasterVolume/MasterSlider
@onready var _music_slider: HSlider = $VBoxContainer/MusicVolume/MusicSlider
@onready var _sfx_slider: HSlider = $VBoxContainer/SFXVolume/SFXSlider
@onready var _fullscreen_check: CheckBox = $VBoxContainer/Display/FullscreenCheck
@onready var _back_button: Button = $VBoxContainer/BackButton

signal settings_changed(setting: String, value: Variant)
signal back_requested

func _setup_ui() -> void:
	name = "SettingsUI"
	_load_current_settings()

func _connect_signals() -> void:
	if _master_slider:
		_master_slider.value_changed.connect(_on_master_volume_changed)
	if _music_slider:
		_music_slider.value_changed.connect(_on_music_volume_changed)
	if _sfx_slider:
		_sfx_slider.value_changed.connect(_on_sfx_volume_changed)
	if _fullscreen_check:
		_fullscreen_check.toggled.connect(_on_fullscreen_toggled)
	if _back_button:
		_back_button.pressed.connect(_on_back_pressed)

func _load_current_settings() -> void:
	if _master_slider:
		_master_slider.value = AudioManager.get_master_volume()
	if _music_slider:
		_music_slider.value = AudioManager.get_music_volume()
	if _sfx_slider:
		_sfx_slider.value = AudioManager.get_sfx_volume()

func _on_master_volume_changed(value: float) -> void:
	AudioManager.set_master_volume(value)
	settings_changed.emit("master_volume", value)

func _on_music_volume_changed(value: float) -> void:
	AudioManager.set_music_volume(value)
	settings_changed.emit("music_volume", value)

func _on_sfx_volume_changed(value: float) -> void:
	AudioManager.set_sfx_volume(value)
	settings_changed.emit("sfx_volume", value)

func _on_fullscreen_toggled(is_fullscreen: bool) -> void:
	if is_fullscreen:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
	else:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
	settings_changed.emit("fullscreen", is_fullscreen)

func _on_back_pressed() -> void:
	back_requested.emit()
