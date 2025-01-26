extends Node

## Game manager which controls the state of the game

enum GameState {PLAYING,FAILED, WIN}

## Key: [Resources.type]
## Value: float
var resources : Dictionary= {} 
var production_bonuses:= PerResourceStats.new()
var cities: Array[City]
## dictionary of available ore deposits on the map
## key: ore type
## value: array of deposits of that type
var ore_deposits: Dictionary={}

var _blackout : bool = false
var frame_duration : float = 0.1

var state: GameState = GameState.PLAYING
var blackout_audio_source: AudioStreamPlayer

func _init() -> void:
	for type in Resources.type.values():
		if type == Resources.type.TERRAFORMATION:
			resources[type] = 100
		else:
			resources[type] = 0
	for type in Ore.type.values():
		ore_deposits[type] = []
	blackout_audio_source = AudioStreamPlayer.new()
	add_child(blackout_audio_source)
	blackout_audio_source.stream = load("res://Art/audio/blackout.wav")

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
		var energy_sum = calc_energy()
		if energy_sum < 0:
			_start_blackout()
		else:
			_produce(delta)
		update_ui()
	if state == GameState.PLAYING:
		if resources.get(Resources.type.TERRAFORMATION )<= 0:
			state = GameState.FAILED
			fail_game()
		if resources.get(Resources.type.TERRAFORMATION) >= 1000:
			state = GameState.WIN
			win_game()
	

func add_city(city: City):
	cities.append(city)

func add_deposit(ore: Ore, type: Ore.type):
	ore_deposits.get(type).append(ore)
	
func calc_energy() -> float:
	var energy = 0	
	
	for city in cities:
		energy += city.calc_energy()
	
	resources[Resources.type.ENERGY] = energy	 
	return energy

func _start_blackout():
	print("BLACKOUT")
	_blackout = true
	blackout_audio_source.play()

func _produce(delta: float):
	for city in cities:
		if city.active:
			city.produce(delta)
	for production : Resources.type in production_bonuses.resources:
		add_resource(production, production_bonuses.resources[production])

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

func can_afford(reqs: Array[Production])-> bool:
	for req in reqs:
		if resources.get(req.type) < req.amount:
			return false
	return true

func add_resource(type: Resources.type, amount: float) -> void:
	resources[type] = resources.get(type) + amount

func subtract_resource(type: Resources.type, amount: float) -> void:
	resources[type] = resources.get(type) + amount

func add_production_bonus(type: Resources.type, amount: float) -> void:
	production_bonuses.resources[type] += amount
	
func subtract_production_bonus(type: Resources.type, amount: float) -> void:
	production_bonuses.resources[type] -= amount

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
	return true

func in_city_max_range(ghost_pos: Vector3, max_radius:float)->bool:
	if len(cities) == 0:
		return true
	for city in cities:
		var distance := city.position.distance_to(ghost_pos)
		if  distance <=  max_radius:
			return true
	return false

func is_point_on_ore(point:Vector3, ore_type: Ore.type, dist: float)->bool:
	for deposit in ore_deposits.get(ore_type):
		var distance = deposit.position.distance_to(point) 
		if distance <= dist:
			return true
	return false

func get_ore_deposit(point:Vector3, ore_type: Ore.type)->Ore:
	for deposit in ore_deposits.get(ore_type):
		var distance = deposit.position.distance_to(point) 
		if distance <= 1:
			return deposit
	return null

func fail_game():
	var fail_ui = load("res://Prefabs/UI/fail_screen.tscn")
	var instance = fail_ui.instantiate()
	add_child(instance)
	
func win_game():
	var win_ui = load("res://Prefabs/UI/win_screen.tscn")
	var instance = win_ui.instantiate()
	add_child(instance)
