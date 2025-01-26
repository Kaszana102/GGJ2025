class_name StructurePlacer

extends Node

@export var _camera: RaycastCamera3D
@export var build_sound_source: AudioStreamPlayer
@export var build_error_sound_source: AudioStreamPlayer

var _structure_ghost: StructureGhost


func set_structure_ghost(structure_ghost_prefab: PackedScene) -> void:
	var ghost = structure_ghost_prefab.instantiate()
	get_tree().get_root().add_child(ghost)
	
	_structure_ghost = ghost

func clear_structure_ghost() -> void:
	_structure_ghost.queue_free()
	_structure_ghost = null

func place_structure() -> void:
	if has_structure_ghost():
		var placed_structure = self._structure_ghost.place()
		if placed_structure != null:
			if _structure_ghost.needed_deposit_ore != null:
				placed_structure.ore_deposit = (
					GameManager.get_ore_deposit(
						placed_structure.position,
						_structure_ghost.needed_deposit_ore.type))
			self.clear_structure_ghost()
			play_legal_placement_sound()
		else:
			play_illegal_placement_sound()
		pass

func play_legal_placement_sound()->void:
	build_sound_source.play()
func play_illegal_placement_sound()->void:
	build_error_sound_source.play()

func has_structure_ghost() -> bool:
	return _structure_ghost != null

func _process(delta: float) -> void:
	if _structure_ghost:
		var place_position = _camera.get_raycast_position()
		if place_position:
			_structure_ghost.position = place_position
			_structure_ghost.can_place()
