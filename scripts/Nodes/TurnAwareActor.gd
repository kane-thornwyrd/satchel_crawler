class_name TurnAwareActor
extends Node2D

signal turn_phase_ready(phase)


func our_turn_start(_tm: TurnManager):
	print_debug("[OUR SIDE] INIT !")
	emit_signal("turn_phase_ready", "our_turn_start")


func our_turn(_tm: TurnManager):
	print_debug("[OUR SIDE] We play our turn  !")
	emit_signal("turn_phase_ready", "our_turn_end")


func our_turn_end(_tm: TurnManager):
	print_debug("[OUR SIDE] CLOSE !")
	emit_signal("turn_phase_ready", "our_turn_end")


func their_turn_start(_tm: TurnManager):
	print_debug("[THEIR SIDE] INIT !")
	emit_signal("turn_phase_ready", "their_turn_start")


func their_turn(_tm: TurnManager):
	emit_signal("turn_phase_ready", "their_turn_start")
	print_debug("[THEIR SIDE] We play our turn  !")
	_tm.turn = _tm.TurnTypes.OUR_TURN


func their_turn_end(_tm: TurnManager):
	print_debug("[THEIR SIDE] CLOSE !")
	emit_signal("turn_phase_ready", "their_turn_end")
