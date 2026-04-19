extends Node

var _current_scene: Node = null

func _ready() -> void:
	get_tree().auto_accept_quit = false
	_load_main_menu()

func _load_main_menu() -> void:
	var main_menu_scene: PackedScene = load("res://scenes/menu.tscn")
	_change_scene(main_menu_scene)

func _change_scene(scene_packed: PackedScene) -> void:
	if _current_scene != null:
		_current_scene.queue_free()
	
	_current_scene = scene_packed.instantiate()
	add_child(_current_scene)
	
	if _current_scene.has_signal("start_game_requested"):
		_current_scene.start_game_requested.connect(_on_start_game_requested)
	
	if _current_scene.has_signal("settings_requested"):
		_current_scene.settings_requested.connect(_on_settings_requested)
	
	if _current_scene.has_signal("quit_requested"):
		_current_scene.quit_requested.connect(_on_quit_requested)
	
	if _current_scene.has_signal("back_requested"):
		_current_scene.back_requested.connect(_on_back_requested)

func _on_start_game_requested() -> void:
	var game_scene: PackedScene = load("res://scenes/game.tscn")
	_change_scene(game_scene)

func _on_settings_requested() -> void:
	var settings_scene: PackedScene = load("res://scenes/settings.tscn")
	_change_scene(settings_scene)

func _on_back_requested() -> void:
	_load_main_menu()

func _on_quit_requested() -> void:
	get_tree().quit()

func _notification(what: int) -> void:
	if what == NOTIFICATION_WM_CLOSE_REQUEST:
		get_tree().quit()
