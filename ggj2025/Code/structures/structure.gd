class_name Structure

extends Node3D


## energy consumption per second
@export var energy_consumption : float  = 1

@export var production: ProductionBalance

var ore_deposit: Ore

func _ready() -> void:
	var city: City = get_parent()
	city.add_structure(self)

## produces resource in given delta time
## doesn consume energy, as it is calculated in gamemanager already
func produce(delta: float) -> Array[Production]:
	if not production:
		return [] # todo awful fix
	if production.products.size() == 0:
		return []
	var percentage = 1 # 100%
	
	if production.requirement != null:
		var taken_amount = (GameManager.get_resource(
			production.requirement.type,
			production.requirement.amount * delta
		))
		percentage = taken_amount/(production.requirement.amount * delta)
	
	var products:Array[Production] = []
	for product in production.products:
		var produced_amount = product.amount * percentage * delta
		products.append(Production.construct(product.type,
			produced_amount))
	return products
	
## positive meanit adds energy
## not taking time into account
func energy_influcce():
	if production:
		return production.produced_energy()
	else:
		return 0  # TODO awful fix
