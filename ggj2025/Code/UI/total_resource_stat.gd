class_name TotalResourceStat
extends BoxContainer


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func set_type(type: Resources.type):
	$Background/Icon.set_variant(type)

func set_production_text(amount: float):
	$Background/Production.text = String.num(amount).pad_decimals(1) + "/s"
	
func set_total(amount: float):
	$Background/Total.text = String.num(amount).pad_decimals(1)
