class_name City

extends Node3D

const FARM = preload("res://Prefabs/Structures/farm.tscn")
const GENERATOR = preload("res://Prefabs/Structures/generator.tscn")
const IRON = preload("res://Prefabs/Structures/iron_mine.tscn")
const COAL = preload("res://Prefabs/Structures/coal_mine.tscn")
const TERRAFORM = preload("res://Prefabs/Structures/terraformation_struct.tscn")

@export var extension_place_distance : float = 1.5
@export var active : bool = true
@export var max_structures : int = 6
var structures: Array[Structure]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	GameManager.add_city(self)

func set_active(state: bool):
	active = state # TODO add logic to it
	print("active: ", state)
	
	for child in get_children():
		if child.has_method("set_active"):
			child.set_active(state)
	
	for structure in structures:
		structure.set_active(state)
	
func toggle_active():
	set_active(not active)
	
	
func place_extension(prefab: PackedScene) -> void:
	if len(structures) == max_structures:
		return
	var extension_position = Vector3(1, 0, 0) * extension_place_distance
	extension_position = extension_position.rotated(Vector3(0, 1, 0), deg_to_rad(360.0/max_structures * len(structures)))
	print(len(structures))
	print(extension_position)
	
	var extension = prefab.instantiate()
	extension.position = extension_position

	add_child(extension)
	
func build_farm() -> void:
	if GameManager.can_afford([Production.construct(Resources.type.IRON, 100)]):
		place_extension(FARM)

func build_generator() -> void:
	if GameManager.can_afford([Production.construct(Resources.type.IRON, 45)]):
		place_extension(GENERATOR)
		GameManager.subtract_resource(Resources.type.IRON, 45)

func build_coal_mine() -> void:
	if (GameManager.can_afford([Production.construct(Resources.type.IRON, 25)])):
		GameManager.subtract_resource(Resources.type.IRON, 25)
		place_extension(COAL)

func build_iron_mine() -> void:
	if (GameManager.can_afford([Production.construct(Resources.type.IRON, 25)])):
		GameManager.subtract_resource(Resources.type.IRON, 25)
		place_extension(IRON)

func build_terraform() -> void:
	if GameManager.can_afford([Production.construct(Resources.type.IRON, 100)]):
		GameManager.subtract_resource(Resources.type.IRON, 100) 
		place_extension(TERRAFORM)

func add_structure(structure: Structure)->void:
	structures.append(structure)

func produce(delta: float)->void:
	var products : Array[Production]= []
	for structure in structures:
		var new_products = structure.produce(delta)
		add_production(products, new_products)
	for product in products:
		GameManager.add_resource(product.type,product.amount)

func add_production(current: Array[Production], new_product:Array[Production])->void:
	for new in new_product:
		for cur in current:
			if cur.type == new.type:
				cur.amount += new.amount
		current.append(Production.construct(new.type,new.amount))	
	
func calc_energy()->float:
	var energy_consumption = 0
	for structure in structures:
		energy_consumption += structure.energy_influcce()
	
	return energy_consumption
