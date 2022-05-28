class_name SelectModFolderField
extends Control

export(NodePath) var open_button_path
export(NodePath) var filedialog_path
export(NodePath) var label_path

var open_button: BrightTextureButton
var filedialog: FileDialog
var label: LineEdit
var _selected_folder_path: String
var _selected_folder_path_position: int = 0


func _ready() -> void:
	open_button = get_node(open_button_path)
	filedialog = get_node(filedialog_path)
	label = get_node(label_path)
	open_button.connect("pressed", self, "_on_button_pressed")
	filedialog.connect("dir_selected", self, "_on_dir_selected")


func _set_label(t: String) -> void:
	label._on_text_changed(t)
	label.text = t.substr(t.length() - 67) + "..."


func _on_button_pressed() -> void:
	filedialog.popup_centered_clamped()


func _on_dir_selected(dir: String) -> void:
	_set_label(dir)
