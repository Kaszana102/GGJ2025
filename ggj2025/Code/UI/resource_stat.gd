class_name ResourceStat

extends HBoxContainer

var _resource_type_to_display: Resources.type
var resource_amount_label : Label

func _init(name: String):
	_resource_type_to_display = Resources.type[name]
	
	var resource_image_label = Label.new() # TODO convert to some image label
	resource_image_label.text = name
	
	resource_amount_label = Label.new()
	resource_amount_label.text = "0"
	
	add_child(resource_image_label)
	add_child(resource_amount_label)
	# TODO add some const size of this container
	

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var amount_float = GameManager.resources.get(_resource_type_to_display)
	resource_amount_label.text = str(amount_float).pad_decimals(1) 
