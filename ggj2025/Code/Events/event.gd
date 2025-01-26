class_name GameEvent
extends Resource

@export var title: String
@export var description: String

@export var choices: Array [EventChoice] # array of type EventChoice
func _ready() -> void:
	pass
func _process(delta: float) -> void:
	pass
	
func can_occur() -> bool :
	return true

func doesitwork() -> void:
	print("it works!")

func apply_effects(choice: int) -> void:
	print("TODO", choice)
# TODO : implement interaction with resources
