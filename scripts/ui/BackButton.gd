class_name BackButton
extends BrightTextureButton

export(String) var previous


func _ready() -> void:
	connect("button_down", self, "_on_button_pressed")


func _on_button_pressed():
	SceneManager.change_scene(
		Global.previous_scene,
		Global.fade_out_options,
		Global.fade_in_options,
		Global.general_options
	)
