class_name Utils

static func random_int(min_val: int, max_val: int) -> int:
	return randi_range(min_val, max_val)

static func random_float(min_val: float, max_val: float) -> float:
	return randf_range(min_val, max_val)

static func shuffle_array(arr: Array) -> Array:
	var result: Array = arr.duplicate()
	result.shuffle()
	return result

static func clamp_value(value: Variant, min_val: Variant, max_val: Variant) -> Variant:
	return clamp(value, min_val, max_val)

static func lerp_value(from: Variant, to: Variant, weight: float) -> Variant:
	return lerp(from, to, weight)

static func format_time(seconds: float) -> String:
	var mins: int = int(seconds) / 60
	var secs: int = int(seconds) % 60
	return "%02d:%02d" % [mins, secs]

static func deep_copy(dictionary: Dictionary) -> Dictionary:
	return dictionary.duplicate(true)
