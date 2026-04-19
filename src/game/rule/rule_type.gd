class_name RuleType
extends RefCounted

enum MeldType { PENG, GANG, CHI, AN_GANG }
enum WinType { ZIMO, DIANPAO, QIANGGANG }

static func get_meld_name(meld_type: MeldType) -> String:
	match meld_type:
		MeldType.PENG: return "碰"
		MeldType.GANG: return "明杠"
		MeldType.CHI: return "吃"
		MeldType.AN_GANG: return "暗杠"
		_: return "未知"

static func get_win_name(win_type: WinType) -> String:
	match win_type:
		WinType.ZIMO: return "自摸"
		WinType.DIANPAO: return "点炮"
		WinType.QIANGGANG: return "抢杠"
		_: return "未知"
