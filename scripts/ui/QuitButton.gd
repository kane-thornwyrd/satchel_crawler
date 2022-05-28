class_name QuitButton
extends BrightTextureButton


func _ready() -> void:
	connect("button_down", self, "_on_button_pressed")


func _on_button_pressed():
	Global.quit()
