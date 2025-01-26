class_name ResourceIcon
extends TextureRect

var food_texture = preload("res://Art/ui textures/food-icon.png")
var coal_texture = preload("res://Art/ui textures/coal-icon.png")
var iron_texture = preload("res://Art/ui textures/iron-icon.png")
var power_texture = preload("res://Art/ui textures/power-icon.png")
var terraformation_texture = preload("res://Art/ui textures/terraformation-icon.png")
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	pass # Replace with function body.

func set_variant(type: Resources.type):
	match type:
		Resources.type.COAL:
			texture = coal_texture
		Resources.type.ENERGY:
			texture = power_texture
		Resources.type.IRON:
			texture = iron_texture
		Resources.type.TERRAFORMATION:
			texture = terraformation_texture
		Resources.type.FOOD:
			texture = food_texture

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
