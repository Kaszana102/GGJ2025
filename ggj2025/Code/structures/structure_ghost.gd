class_name StructureGhost

extends Node3D

## StructureGhost is an "unplaced" structure. Will be converted to its corresponding
## "real" structure when place() is called

## The structure that will be placed
@export var structure: PackedScene

func can_place() -> bool:
	return true  # todo

func place() -> bool:
	if not can_place():
		return false
		
	var placed_structure = structure.instantiate()
	placed_structure.transform = global_transform
	get_tree().get_root().add_child(placed_structure)
	return true

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
