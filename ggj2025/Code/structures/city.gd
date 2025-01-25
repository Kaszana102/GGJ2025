class_name City

extends Structure


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	GameManager.add_city(self)
