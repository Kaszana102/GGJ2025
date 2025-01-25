class_name Structure

extends Node3D


## energy consumption per second
@export var energy_consumption : float  = 1
@export var active : bool = true

@export var production: ProductionBalance = ProductionBalance.new()

var ore_deposit: Ore

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if production.produces_energy():
		GameManager.add_generator(self)
	else:
		GameManager.add_structure(self)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if(active):
		pass

func set_active(state: bool):
	active = state

## produces resource in given delta time
## doesn consume energy, as it is calculated in gamemanager already
func produce(delta: float):
	if production.products.size() == 0:
		return 0
	var percentage = 1 # 100%
	
	if production.requirement != null:
		var taken_amount = (GameManager.get_resource(
			production.requirement.type,
			production.requirement.amount * delta
		))
		percentage = taken_amount/(production.requirement.amount * delta)
	
	for product in production.products:		
		var produced_amount = product.amount * percentage * delta
		GameManager.add_resource(
			product.type,
			produced_amount
		)	
	
