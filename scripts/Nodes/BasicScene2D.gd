class_name BasicScene2D
extends Node2D


func _ready() -> void:
	Global.previous_scene = Global.current_scene
	Global.current_scene = self.name
	if self.name == "Void":
		Global.quit()
