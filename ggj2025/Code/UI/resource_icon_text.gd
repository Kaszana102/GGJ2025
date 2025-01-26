class_name ResourceIconText
extends BoxContainer


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func set_type(type: Resources.type):
	$Icon.set_variant(type)

func set_amount_text(amount: float, text: String):
	$Count.text = text + String.num(amount)
