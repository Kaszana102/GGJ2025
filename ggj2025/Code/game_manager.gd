extends Node

## Game manager which controls the state of the game

## Key: [Resources.type]
## Value: float
var resources : Dictionary= {} 
## list of all non generating power structures
var structures: Array[Structure]
## list of all non generating power structures
var power_generators: Array[Structure]

var _blackout : bool = false

var frame_duration : float = 0.1

func _init() -> void:
	for type in Resources.type.values():
		resources[type] = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var timer = Timer.new()
	timer.wait_time = frame_duration
	timer.connect("timeout", _fixed_process)
	timer.autostart = true
	timer.start()
	add_child(timer)

func _fixed_process() -> void:
	var delta := frame_duration
	if !_blackout:
		var energy_sum = calc_energy(delta)
		if energy_sum < 0:
			_start_blackout()
		else:
			_produce(delta)
		update_ui()

func add_structure(structure : Structure):
	structures.append(structure)
	
func add_generator(generator : Structure):
	power_generators.append(generator)
	
func calc_energy(delta: float) -> float:
	resources[Resources.type.ENERGY] = 0
	for generator in power_generators:
		if generator.active:
			generator.produce(delta) # energy added to resources
	
	var energy_consumption = 0
	for structure in structures:
		if structure.active:
			energy_consumption += structure.energy_consumption * delta
	return (resources.get(Resources.type.ENERGY)-energy_consumption) * (1.0/delta)

func _start_blackout():
	print("BLACKOUT")
	_blackout = true

func _produce(delta: float):
	for structure in structures:
		if structure.active:
			structure.produce(delta)

## get resources from the game manager
## returns true if succesful
func get_resource(type: Resources.type, amount: float) -> float:
	if resources[type] >= amount:
		resources[type] -= amount
		return amount
	var return_amount = resources[type]
	resources[type] = 0
	return return_amount

func add_resource(type: Resources.type, amount: float) -> void:
	resources[type] = resources.get(type) + amount

func update_ui():
	pass
