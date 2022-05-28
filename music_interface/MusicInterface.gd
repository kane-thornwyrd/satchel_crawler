extends Control

onready var asp: AudioStreamPlayer = $asp
onready var label: RichTextLabel = $Panel/HBoxContainer/label

var musics: Dictionary = Dictionary()
var current_track: int = 0

static func recurs_list_files_in_directory(path):
	var files = []
	var dir = Directory.new()
	var is_import = RegEx.new()
	is_import.compile("\\.import$")

	dir.open(path)
	dir.list_dir_begin(true, true)

	var current_address: String = path

	while true:
		var file = dir.get_next()
		if file == "":
			break
		if is_import.search(file) != null:
			continue

		if dir.current_is_dir():
			files.append_array(recurs_list_files_in_directory(current_address + "/" + file))
		else:
			if not file.begins_with("."):
				files.append(current_address + "/" + file)

	dir.list_dir_end()

	return files


func _ready() -> void:
	var root: String = "res://assets/musics"
	var raw_list: PoolStringArray = recurs_list_files_in_directory(root)

	for file in raw_list:
		var title = file.replace(".ogg", "").replace(root + "/", "").replace("/", " - ")
		musics[title] = file

	play()


func play(track_index = null) -> void:
	if track_index != null:
		current_track = track_index

	var title = RegEx.new()
	title.compile("^\\s*(?<artist>[a-zA-Z _]+)\\s+-\\s+(?<track>[a-zA-Z\\s&!_-]+)\\s*$")
	var res = title.search(musics.keys()[current_track])

	var datas: AudioStreamOGGVorbis = load(musics.values()[current_track])

	if res:
		label.set_bbcode("[b]" + res.get_string("artist") + "[/b] - " + res.get_string("track"))
	else:
		print_debug(musics.keys()[current_track])
	asp.set_stream(datas)
	asp.play()


func play_next() -> void:
	if current_track == musics.size() - 1:
		current_track = 0
	else:
		current_track = (current_track % (musics.size() - 1)) + 1

	play(current_track)


func play_prev() -> void:
	if current_track == 0:
		current_track = musics.size() - 1
	else:
		current_track = (current_track % (musics.size() - 1)) - 1

	play(current_track)

func toggle_play() -> void:
	if asp.playing:
		asp.playing = false
	else:
		asp.playing = true
