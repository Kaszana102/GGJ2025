extends Node

## Game manager which controls the state of the game

## Key: [Resources.type]
## Value: float
var resources : Dictionary= {} 
## list of all non generating power structures
var structures: Array[Structure]
## list of all non generating power structures
var power_generators: Array[Structure]
var cities: Array[City]
## dictionary of available ore deposits on the map
## key: ore type
## value: array of deposits of that type
var ore_deposits: Dictionary={}

var _blackout : bool = false

var frame_duration : float = 0.1

func _init() -> void:
	for type in Resources.type.values():
		resources[type] = 0
	for type in Ore.type.values():
		ore_deposits[type] = []

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var timer = Timer.new()
	timer.wait_time = frame_duration
	timer.connect("timeout", _fixed_process)	
	add_child(timer)
	timer.autostart = true
	timer.start()

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

func add_city(city: City):
	cities.append(city)

func add_deposit(ore: Ore, type: Ore.type):
	ore_deposits.get(type).append(ore)
	
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
	
func has_resource(type: Resources.type, amount: float) -> bool:
	if resources[type] >= amount:
		return true
	return false

func add_resource(type: Resources.type, amount: float) -> void:
	resources[type] = resources.get(type) + amount

func update_ui():
	pass

func can_place_structure(ghost_pos: Vector3, min_radius:float, max_radius:float)->bool:
	if len(cities) == 0:
		return true
	for city in cities:
		var distance := city.position.distance_to(ghost_pos)
		if   min_radius <= distance and distance <=  max_radius:
			return true
	return false

func outside_min_range(ghost_pos: Vector3, min_radius:float)->bool:
	for city in cities:
		var distance := city.position.distance_to(ghost_pos)
		if  distance <  min_radius:
			return false
	for structure in structures:
		var distance := structure.position.distance_to(ghost_pos)
		if  distance < min_radius:
			return false
	return true

func in_city_max_range(ghost_pos: Vector3, max_radius:float)->bool:
	if len(cities) == 0:
		return true
	for city in cities:
		var distance := city.position.distance_to(ghost_pos)
		if  distance <=  max_radius:
			return true
	return false

func is_point_on_ore(point:Vector3, ore_type: Ore.type)->bool:
	for deposit in ore_deposits.get(ore_type):
		var distance = deposit.position.distance_to(point) 
		if distance <= 1:
			return true
	return false

func get_ore_deposit(point:Vector3, ore_type: Ore.type)->Ore:
	for deposit in ore_deposits.get(ore_type):
		var distance = deposit.position.distance_to(point) 
		if distance <= 1:
			return deposit
	return null
