class_name TestUI

extends Node

@export var _structure_placer: StructurePlacer

@export var _structure_ghost_prefab: PackedScene


func _spawn_structure_ghost() -> StructureGhost:
	var ghost = _structure_ghost_prefab.instantiate()
	get_tree().get_root().add_child(ghost)
	
	return ghost
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_key_pressed(KEY_ESCAPE):
		print("esc")
		if _structure_placer.has_structure_ghost():
			print("cancel structure")
			_structure_placer.clear_structure_ghost()
	if Input.is_key_pressed(KEY_1):
		print("1")
		if not _structure_placer.has_structure_ghost():
			print("set structure")
			var ghost = _spawn_structure_ghost()
			_structure_placer.set_structure_ghost(ghost)
			
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
		_structure_placer.place_structure()
