class_name GameEvent
extends Resource

@export var title: String
@export var description: String

@export var choices: Array [EventChoice] # array of type EventChoice
signal event_choice_made

func _ready() -> void:
	pass
func _process(delta: float) -> void:
	pass
	
func can_occur() -> bool :
	return true

func doesitwork() -> void:
	print("it works!")

func apply_effects(choice: int) -> void:
	var bonuses: Dictionary = choices[choice].effects.bonus
	var costs: Dictionary = choices[choice].effects.cost
	
	for resource in bonuses:
		GameManager.add_resource(resource, bonuses[resource])
	for resource in costs:
		GameManager.subtract_resource(resource, costs[resource])
	event_choice_made.emit()
	print("TODO", choice)
# TODO : implement interaction with resources
