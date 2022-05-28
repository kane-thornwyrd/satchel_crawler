class_name Game
extends BasicScene2D

# var turn_manager = preload("res://TurnManager.tres")
export(Resource) var turn_manager
export(NodePath) var change_turn_button_path

onready var change_turn_button: BaseButton = get_node(change_turn_button_path)


func _ready() -> void:
	turn_manager.operate_on(self)
	change_turn_button.connect("pressed", self, "_change_turn")
	turn_manager.connect("our_turn_end", self, "_disable_button")
	turn_manager.connect("phase_finished_our_turn", self, "_enable_button")
	turn_manager.turn = turn_manager.TurnTypes.OUR_TURN


func _change_turn() -> void:
	turn_manager.turn = TurnManager.TurnTypes.THEIR_TURN


func _disable_button(_w):
	change_turn_button.disabled = true


func _enable_button(_w):
	change_turn_button.disabled = false
