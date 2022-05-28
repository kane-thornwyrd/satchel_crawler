class_name PopUpMenu
extends Control

export(NodePath) var toggle_path
export(NodePath) var dangling_light_path
export(NodePath) var popup_animator_path

var dangling_light: DanglingLight
var popup_animation_player: AnimationPlayer
var toggleButton: BaseButton

var _opened: bool = true


func _ready() -> void:
	dangling_light = get_node(dangling_light_path)
	popup_animation_player = get_node(popup_animator_path)
	toggleButton = get_node(toggle_path)
	if toggleButton:
		toggleButton.connect("pressed", self, "toggleOpen")
		open()


func open():
	popup_animation_player.play("open")
	dangling_light.light_up()
	_opened = true


func close():
	dangling_light.light_down()
	yield(get_tree().create_timer(0.15), "timeout")
	popup_animation_player.play("close")
	_opened = false


func toggleOpen():
	if not _opened:
		open()
	else:
		close()
