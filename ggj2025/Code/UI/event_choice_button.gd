class_name EventChoiceButton
extends TextureButton

var _event
var _id
var _choice : EventChoice

func with_data(event: GameEvent, choice_id: int) -> EventChoiceButton:
	# TODO: display cost and bonus
	_event = event
	_id = choice_id
	_choice =  _event.choices[_id]
	return self
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Text.text = _choice.description
	connect("pressed",_event.apply_effects.bind(_id))
	var costs = _choice.effects.cost
	var bonuses = _choice.effects.bonus
	# COPIED CODE - bad practice, yes, no time
	for resource in costs:
		if costs[resource] > 0:
			var icon_display: ResourceIconText = preload("res://Prefabs/UI/resource_icon_text.tscn").instantiate() as ResourceIconText
			icon_display.set_amount_text(costs[resource], "-")
			icon_display.set_type(resource)
			$Resources.add_child(icon_display)
	
	for resource in bonuses:
		if bonuses[resource] > 0:
			var icon_display: ResourceIconText = preload("res://Prefabs/UI/resource_icon_text.tscn").instantiate() as ResourceIconText
			icon_display.set_amount_text(bonuses[resource], "+")
			icon_display.set_type(resource)
			$Resources.add_child(icon_display)
			
func requirements_met() -> bool:
	var costs: Dictionary = _choice.effects.cost
	
	for resource in costs:
		if !GameManager.has_resource(resource, costs[resource]):
			return false
	return true
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	disabled = not requirements_met()
