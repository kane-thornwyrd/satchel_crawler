extends Node


func preloadMods():
	var mods_dir = Directory.new()
	if mods_dir.open(Global.mod_folder_path) == OK:
		mods_dir.list_dir_begin()
		var fileMod = mods_dir.get_next()
		while fileMod != "":
			if ".gd" in fileMod:
				Global.nodeModList.add_item(fileMod)
