extends Node

## Key: [Resources.type]
## Value: float
var resources : Dictionary= {} 

func _init() -> void:
	for type in Resources.type:
		resources[type] = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
