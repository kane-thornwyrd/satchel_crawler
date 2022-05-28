class_name Main
extends BasicScene2D

export(float, 0, 1, 0.05) var fade_out_speed = 1
export(float, 0, 1, 0.05) var fade_in_speed = 1
export(float, 0, 1, 0.1) var fade_out_smoothness = 0.1
export(float, 0, 1, 0.1) var fade_in_smoothness = 0.1
export(bool) var fade_out_inverted = false
export(bool) var fade_in_inverted = false
export(float, 0, 2, 0.05) var timeout = 1
export(bool) var clickable = true

var fade_out_pattern = "pixel"
var fade_in_pattern = "pixel"


func _ready() -> void:
	var color = ProjectSettings.get("application/boot_splash/bg_color")
	var first_scene_general_options = SceneManager.create_general_options(color, 1, false)
	Global.fade_out_options = SceneManager.create_options(
		fade_out_speed, fade_out_pattern, fade_out_smoothness, fade_out_inverted
	)
	Global.fade_in_options = SceneManager.create_options(
		fade_in_speed, fade_in_pattern, fade_in_smoothness, fade_in_inverted
	)
	Global.general_options = SceneManager.create_general_options(color, timeout, clickable)

	SceneManager.show_first_scene(Global.fade_in_options, first_scene_general_options)
