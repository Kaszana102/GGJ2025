class_name EventPopup

extends Control

## class for display all resources in a hbox layout

func _init() -> void:
	pass

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func setup(event_data: GameEvent):
	$Layout/Title.text = event_data.title
	$Layout/Description.text = event_data.description
	for i in range(event_data.choices.size()) :
		var button: EventChoiceButton = preload("res://Prefabs/UI/choice_button.tscn").instantiate().with_data(event_data,i) as EventChoiceButton
		$Layout.add_child(button)
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:	
	pass
