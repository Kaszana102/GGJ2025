class_name ResourceDisplay

extends HBoxContainer

## class for display all resources in a hbox layout

func _init() -> void:
	for type in Resources.type:
		var resourceLabel = ResourceStat.new(type)
		add_child(resourceLabel)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:	
	pass
