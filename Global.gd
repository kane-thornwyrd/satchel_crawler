extends Node

var current_scene: String = "Main"
var previous_scene: String = ""
var fade_out_options
var fade_in_options
var general_options
var mod_folder_path: String
var mod_list: Array


func quit() -> void:
	SceneManager.change_scene(
		"Void", Global.fade_out_options, Global.fade_in_options, Global.general_options
	)
	yield(get_tree().create_timer(0.5), "timeout")
	get_tree().notification(MainLoop.NOTIFICATION_WM_QUIT_REQUEST)
