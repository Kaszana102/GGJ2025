class_name Structure

extends Node3D

	
@export var radius : float = 1
## energy consumption per second
@export var energy_consumption : float  = 1
@export var active : bool = true

## amount per second
@export var produced_resource_type : Resources.type
## amount per second
@export var produced_resource_amount : float
@export var production_requirement : ResourceRequirement

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if produced_resource_type == Resources.type.ENERGY:
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
	if produced_resource_amount == 0:
		return 0
	var percentage = 1 # 100%
	
	if production_requirement != null:
		var taken_amount = (GameManager.get_resource(
			production_requirement.type,
			production_requirement.amount * delta
		))
		percentage = taken_amount/(production_requirement.amount * delta)
	
	var produced_amount = produced_resource_amount * percentage * delta
	GameManager.add_resource(
		produced_resource_type,
		produced_amount
	)
	return produced_amount
	
