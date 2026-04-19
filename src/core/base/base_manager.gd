class_name BaseManager
extends Node

var _is_initialized: bool = false

func _ready() -> void:
	initialize()

func initialize() -> void:
	if _is_initialized:
		return
	_is_initialized = true
	_on_initialize()

func _on_initialize() -> void:
	pass

func dispose() -> void:
	if not _is_initialized:
		return
	_is_initialized = false
	_on_dispose()

func _on_dispose() -> void:
	pass
