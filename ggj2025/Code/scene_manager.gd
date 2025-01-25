class_name SceneManager

extends Node

enum scene {MAIN_MENU, COLONY}

func enum_to_path(target_scene: scene)->String:
	if target_scene == scene.MAIN_MENU:
		return "res://Scenes/main_menu.tscn"
	if target_scene == scene.COLONY:
		return "res://Scenes/colony.tscn"
	return "ERROR"

func load_scene(target_scene: scene):
	get_tree().change_scene_to_file(enum_to_path(target_scene))
	
	
func load_main_menu():
	load_scene(scene.MAIN_MENU)
	
func load_colony():
	load_scene(scene.COLONY)
	
func leave_game():
	get_tree().quit()
