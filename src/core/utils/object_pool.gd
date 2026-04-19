class_name ObjectPool
extends RefCounted

var _pool: Array = []
var _factory: Callable
var _max_size: int = 100

func _init(factory: Callable, initial_size: int = 10, max_size: int = 100) -> void:
	_factory = factory
	_max_size = max_size
	_initialize_pool(initial_size)

func _initialize_pool(size: int) -> void:
	for i: int in range(size):
		var obj: Variant = _factory.call()
		if obj != null:
			_pool.append(obj)

func acquire() -> Variant:
	if _pool.is_empty():
		return _factory.call()
	return _pool.pop_back()

func release(obj: Variant) -> void:
	if _pool.size() < _max_size:
		_pool.append(obj)

func clear() -> void:
	_pool.clear()

func get_pool_size() -> int:
	return _pool.size()
