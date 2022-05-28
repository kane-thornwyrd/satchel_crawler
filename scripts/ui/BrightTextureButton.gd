class_name BrightTextureButton
extends TextureButton

export(NodePath) var light_path = "./Light2D"
export(float, 0.0, 2.0, .1) var light_energy = 0.0

var light: Light2D


func _process(_delta: float) -> void:
	if light == null:
		light = get_node(light_path)

	if self.is_hovered() and light != null:
		light.energy = light_energy
	else:
		light.energy = 0.0
