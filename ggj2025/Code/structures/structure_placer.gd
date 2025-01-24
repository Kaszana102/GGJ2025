class_name StructurePlacer

extends Node

@export var _camera: RaycastCamera3D

var _structure_ghost: StructureGhost


func set_structure_ghost(structure_ghost: StructureGhost) -> void:
	_structure_ghost = structure_ghost

func clear_structure_ghost() -> void:
	_structure_ghost.queue_free()
	_structure_ghost = null

func place_structure() -> void:
	if has_structure_ghost():
		var success = self._structure_ghost.place()
		if success:
			self.clear_structure_ghost()

func has_structure_ghost() -> bool:
	return _structure_ghost != null

func _process(delta: float) -> void:
	if _structure_ghost:
		var place_position = _camera.get_raycast_position()
		if place_position:
			_structure_ghost.position = place_position
