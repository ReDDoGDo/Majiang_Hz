class_name BaseUI
extends Control

var _is_visible: bool = false

func _ready() -> void:
	_setup_ui()
	_connect_signals()

func _setup_ui() -> void:
	pass

func _connect_signals() -> void:
	pass

func show_ui() -> void:
	_is_visible = true
	show()

func hide_ui() -> void:
	_is_visible = false
	hide()

func toggle_ui() -> void:
	if _is_visible:
		hide_ui()
	else:
		show_ui()

func is_ui_visible() -> bool:
	return _is_visible
