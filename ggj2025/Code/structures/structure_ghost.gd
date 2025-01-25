class_name StructureGhost

extends Node3D

## StructureGhost is an "unplaced" structure. Will be converted to its corresponding
## "real" structure when place() is called

## The structure that will be placed
@export var structure: PackedScene

@export var min_radius : float = 1
@export var max_radius : float = 5
@export var needed_deposit_ore : DepositRequirement

@export var place_cost : Array[ResourceRequirement] = []

var min_radius_circle: Node3D
var max_radius_circle: Node3D
var max_radius_ore_circle: Node3D

var min_radius_was:= true
var max_radius_was:= true
var max_radius_ore_was:= true

func _init():
	min_radius_circle = create_radius_circle(Vector3(0,0.01,0),min_radius, Color.RED)
	max_radius_circle = create_radius_circle(Vector3(0,0.03,0),max_radius, Color.YELLOW)
	max_radius_ore_circle = create_radius_circle(Vector3(0,0.06,0),1.0, Color.BLUE)

func create_radius_circle(offset: Vector3, radius: float, color: Color) -> Node3D:
	var circle = MeshInstance3D.new()
	var cylinder :=CylinderMesh.new()
	cylinder.height = 0
	cylinder.top_radius = radius
	cylinder.bottom_radius = radius
	circle.mesh = cylinder
		
	add_child(circle)
	var material = StandardMaterial3D.new()  # Use a new material
	material.transparency = BaseMaterial3D.TRANSPARENCY_ALPHA
	material.albedo_color = color
	material.albedo_color.a = 0.7
	circle.set_surface_override_material(0, material)
	circle.position = offset
	
	circle.visible=false
	return circle

func can_place() -> bool:
	var can := true
	can = can and _far_enough_from_city()
	can = can and _close_enough_from_city()
	can = can and _close_enough_from_ore()
	for resource_cost in place_cost:
		if not GameManager.has_resource(resource_cost.type, resource_cost.amount):
			can = false
			break
			
	if needed_deposit_ore != null:
		can = can and _close_enough_from_ore()
	return can


func _far_enough_from_city()->bool :
	var far_enough = GameManager.outside_min_range(position, min_radius)
	if far_enough and !min_radius_was:
		# hide circle		
		min_radius_circle.visible=false
		pass
	if !far_enough and min_radius_was:
		# show circle
		min_radius_circle.visible=true
		pass
	min_radius_was = far_enough
	return far_enough
	
func _close_enough_from_city()->bool :
	var close_enough = GameManager.in_city_max_range(position, max_radius)
	if close_enough and !max_radius_was:
		# hide circle
		max_radius_circle.visible=false
		pass
	if !close_enough and max_radius_was:
		# show circle
		max_radius_circle.visible=true
		pass
	max_radius_was = close_enough
	return close_enough
	
func _close_enough_from_ore()->bool :
	if needed_deposit_ore != null:
		var close_enough = GameManager.is_point_on_ore(position, needed_deposit_ore.type)
		if close_enough and !max_radius_ore_was:
			#hide circle			
			max_radius_ore_circle.visible=false
			pass 
		if !close_enough and max_radius_ore_was:
			# show circle			
			max_radius_ore_circle.visible=true
			pass
		max_radius_ore_was = close_enough
		return close_enough
	return true

func place() -> Structure:
	if not can_place():
		return null
		
	for resource_cost in place_cost:
		GameManager.get_resource(resource_cost.type, resource_cost.amount)
		
	var placed_structure = structure.instantiate()
	placed_structure.transform = global_transform
	get_tree().get_root().add_child(placed_structure)
	return placed_structure

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
