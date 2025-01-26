class_name ResourceDisplay

extends Control

var resources = GameManager.resources.duplicate(true)
var prev_resources = GameManager.resources.duplicate(true)
## class for display all resources in a hbox layout

func _init() -> void:
	pass
	#for type in Resources.type:
		#var resourceLabel = ResourceStat.new(type)
		#add_child(resourceLabel)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for resource in resources:
		var stat: TotalResourceStat = preload("res://Prefabs/UI/total_resource_stat.tscn").instantiate() as TotalResourceStat
		$container.add_child(stat)
		stat.set_type(resource)
		stat.set_total(resources[resource])
		stat.set_production_text(0)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _physics_process(delta: float) -> void:
	prev_resources = resources.duplicate(true)
	resources = GameManager.resources.duplicate(true)
	for resource in resources:
		var resource_production = 0
		for city in GameManager.cities:
			if resource == Resources.type.ENERGY:
				resource_production -= city.calc_energy()
			for structure in city.structures:
				for product in	structure.production.products:
					if product.type == resource:
						resource_production += product.amount
						
		$container.get_child(resource).set_production_text(resource_production)
		$container.get_child(resource).set_total(resources[resource])
