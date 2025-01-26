class_name ResourceDisplay

extends Control

var resources = GameManager.resources
var prev_resources = GameManager.resources
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
	prev_resources = resources
	resources = GameManager.resources
	for resource in resources:
		var resource_delta : float = resources[resource] - prev_resources[resource]
		$container.get_child(resource).set_production_text(resource_delta / delta)
		$container.get_child(resource).set_total(resources[resource])
