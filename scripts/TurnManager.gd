class_name TurnManager
extends Resource

enum TurnTypes {
	OUR_TURN,
	THEIR_TURN,
}

var PhaseTypes = [
	"our_turn_start",
	"our_turn",
	"our_turn_end",
	"their_turn_start",
	"their_turn",
	"their_turn_end",
]

export(TurnTypes) var turn setget set_turn

var _turn_aware_nodes: Array = []
var _turn_aware_nodes_our_turn_start: Array = []
var _turn_aware_nodes_our_turn: Array = []
var _turn_aware_nodes_our_turn_end: Array = []
var _turn_aware_nodes_their_turn_start: Array = []
var _turn_aware_nodes_their_turn: Array = []
var _turn_aware_nodes_their_turn_end: Array = []

var _group_array_assoc = {
	"our_turn_start": _turn_aware_nodes_our_turn_start,
	"our_turn": _turn_aware_nodes_our_turn,
	"our_turn_end": _turn_aware_nodes_our_turn_end,
	"their_turn_start": _turn_aware_nodes_their_turn_start,
	"their_turn": _turn_aware_nodes_their_turn,
	"their_turn_end": _turn_aware_nodes_their_turn_end,
}

var _current_phase: int = 0 setget _change_phase

signal our_turn_start
signal our_turn
signal our_turn_end
signal their_turn_start
signal their_turn
signal their_turn_end

signal phase_finished_our_turn_start
signal phase_finished_our_turn
signal phase_finished_our_turn_end
signal phase_finished_their_turn_start
signal phase_finished_their_turn
signal phase_finished_their_turn_end


func operate_on(n: Node) -> void:
	_turn_aware_nodes = n.get_tree().get_nodes_in_group("turn_aware")
	for phase in PhaseTypes:
		connect("phase_finished_" + phase, self, "_next_phase")
	for n in _turn_aware_nodes:
		for group in _group_array_assoc.keys():
			if n.is_in_group(group):
				var node_state = {"node": n, "ready": false}
				_group_array_assoc[group].append(node_state)
				connect(group, n, group, [self])
				n.connect("turn_phase_ready", self, "_" + group, [node_state])


func _our_turn_start(phase: String, node_state) -> void:
	node_state.ready = true
	if _is_phase_complete(phase):
		_reset_phase(phase)
		_next_phase()


func _our_turn(phase: String, node_state) -> void:
	node_state.ready = true
	if _is_phase_complete(phase):
		_reset_phase(phase)


func _our_turn_end(phase: String, node_state) -> void:
	node_state.ready = true
	if _is_phase_complete(phase):
		_reset_phase(phase)
		_next_phase()


func _their_turn_start(phase: String, node_state) -> void:
	node_state.ready = true
	if _is_phase_complete(phase):
		_reset_phase(phase)
		_next_phase()


func _their_turn(phase: String, node_state) -> void:
	node_state.ready = true
	if _is_phase_complete(phase):
		_reset_phase(phase)


func _their_turn_end(phase: String, node_state) -> void:
	node_state.ready = true
	if _is_phase_complete(phase):
		_reset_phase(phase)
		_next_phase()


func set_turn(t):
	emit_signal("changed")
	turn = t
	match t:
		TurnTypes.OUR_TURN:
			emit_signal("their_turn_end")

		TurnTypes.THEIR_TURN:
			emit_signal("our_turn_end")


func _is_phase_complete(phase: String) -> bool:
	var result: bool = true
	for node_state in _group_array_assoc[phase]:
		result = result and node_state["ready"]
	return result


func _reset_phase(phase: String) -> void:
	for node_state in _group_array_assoc[phase]:
		node_state["ready"] = false


func _next_phase() -> void:
	print_debug('[TURN MANAGER] CHANGE PHASE FROM "' + PhaseTypes[_current_phase].to_upper() + '".')
	_change_phase((_current_phase + 1) % (PhaseTypes.size() - 1))


func _change_phase(phase_index):
	emit_signal("phase_finished_" + PhaseTypes[phase_index], PhaseTypes[phase_index])
	print_debug('[TURN MANAGER] CHANGE PHASE TO "' + PhaseTypes[phase_index].to_upper() + '".')
	_current_phase = phase_index
