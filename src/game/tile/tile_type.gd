class_name TileType
extends RefCounted

enum Type { WAN, TIAO, TONG, FENG, ARROW, FLOWER, SEASON }

static func get_type_name(type: Type) -> String:
	match type:
		Type.WAN: return "万"
		Type.TIAO: return "条"
		Type.TONG: return "筒"
		Type.FENG: return "风"
		Type.ARROW: return "箭"
		Type.FLOWER: return "花"
		Type.SEASON: return "季"
		_: return "未知"

static func is_number_tile(type: Type) -> bool:
	return type in [Type.WAN, Type.TIAO, Type.TONG]

static func is_honor_tile(type: Type) -> bool:
	return type in [Type.FENG, Type.ARROW]

static func is_bonus_tile(type: Type) -> bool:
	return type in [Type.FLOWER, Type.SEASON]
