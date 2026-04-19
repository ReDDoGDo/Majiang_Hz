class_name PlayerState
extends RefCounted

enum State { WAITING, DRAWING, PLAYING, WAITING_MELD, MELDING, WON, LOST }

var player_id: int = 0
var current_state: State = State.WAITING
var hand_tiles: Array[TileData] = []
var melded_tiles: Array[Array] = []
var discarded_tiles: Array[TileData] = []
var score: int = 0
var is_dealer: bool = false
var is_online: bool = true

func _init(id: int = 0) -> void:
	player_id = id

func set_state(new_state: State) -> void:
	current_state = new_state

func get_state() -> State:
	return current_state

func add_tile(tile: TileData) -> void:
	hand_tiles.append(tile)

func remove_tile(tile: TileData) -> bool:
	for i: int in range(hand_tiles.size()):
		if hand_tiles[i].id == tile.id:
			hand_tiles.remove_at(i)
			return true
	return false

func discard_tile(tile: TileData) -> void:
	if remove_tile(tile):
		discarded_tiles.append(tile)

func add_meld(tiles: Array[TileData]) -> void:
	melded_tiles.append(tiles)

func get_hand_count() -> int:
	return hand_tiles.size()

func to_dict() -> Dictionary:
	return {
		"player_id": player_id,
		"current_state": current_state,
		"hand_count": hand_tiles.size(),
		"meld_count": melded_tiles.size(),
		"discarded_count": discarded_tiles.size(),
		"score": score,
		"is_dealer": is_dealer,
		"is_online": is_online
	}

static func from_dict(data: Dictionary) -> PlayerState:
	var state: PlayerState = PlayerState.new(data.player_id)
	state.current_state = data.current_state
	state.score = data.score
	state.is_dealer = data.is_dealer
	state.is_online = data.is_online
	return state
