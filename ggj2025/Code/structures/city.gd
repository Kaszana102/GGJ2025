class_name City

extends Node3D

@export var active : bool = true
var structures: Array[Structure]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	GameManager.add_city(self)

func set_active(state: bool):
	active = state # TODO add logic to it

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
