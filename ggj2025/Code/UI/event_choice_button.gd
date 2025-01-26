class_name EventChoiceButton
extends Button

var _event
var _id

func with_data(event: GameEvent, choice_id: int) -> EventChoiceButton:
	# TODO: display cost and bonus
	_event = event
	_id = choice_id
	return self
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	text = _event.choices[_id].description
	connect("pressed",_event.apply_effects.bind(_id))

func requirements_met() -> bool:
	var costs: Dictionary = _event.choices[_id].effects.cost
	
	for resource in costs:
		if !GameManager.has_resource(resource, costs[resource]):
			return false
	return true
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	disabled = not requirements_met()
