class_name TurnPhase
extends RefCounted

enum Phase { 
	DRAW, 
	DRAW_FLOWER, 
	PLAY, 
	WAIT_MELD, 
	MELD, 
	WAIT_WIN, 
	WIN, 
	END 
}

static func get_phase_name(phase: Phase) -> String:
	match phase:
		Phase.DRAW: return "摸牌"
		Phase.DRAW_FLOWER: return "补花"
		Phase.PLAY: return "出牌"
		Phase.WAIT_MELD: return "等待操作"
		Phase.MELD: return "操作"
		Phase.WAIT_WIN: return "等待胡牌"
		Phase.WIN: return "胡牌"
		Phase.END: return "结束"
		_: return "未知"
