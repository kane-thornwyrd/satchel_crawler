class_name MainMenuButton
extends BrightTextureButton


func _ready() -> void:
	connect("button_down", self, "_on_button_pressed")


func _on_button_pressed():
	SceneManager.change_scene(
		"Main", Global.fade_out_options, Global.fade_in_options, Global.general_options
	)
