class_name StructureGhost

extends Node3D

## StructureGhost is an "unplaced" structure. Will be converted to its corresponding
## "real" structure when place() is called

## The structure that will be placed
@export var structure: PackedScene

@export var min_radius : float = 1
@export var max_radius : float = 5

@export var place_cost : Array[ResourceRequirement] = []

func can_place() -> bool:
	var can := GameManager.can_place_structure(position, min_radius,max_radius)
	for resource_cost in place_cost:
		if not GameManager.has_resource(resource_cost.type, resource_cost.amount):
			can = false
			break
	
	if can:
		pass
	else:
		pass
	return can

func place() -> bool:
	if not can_place():
		return false
		
	for resource_cost in place_cost:
		GameManager.get_resource(resource_cost.type, resource_cost.amount)
		
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
