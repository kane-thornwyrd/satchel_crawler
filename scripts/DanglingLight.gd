class_name DanglingLight
extends Light2D

signal animation_finished

onready var animation_player: AnimationPlayer = self.get_children()[0]


func _animation_finished():
	emit_signal("animation_finished")


func light_up():
	if animation_player:
		animation_player.play("light_up")
		yield(animation_player, "animation_finished")
		animation_player.play("torch")
		yield(animation_player, "animation_finished")
		_animation_finished()


func light_down():
	if animation_player:
		animation_player.play("light_down")
		yield(animation_player, "animation_finished")
		_animation_finished()
