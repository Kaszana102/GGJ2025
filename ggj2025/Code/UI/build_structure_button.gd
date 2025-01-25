class_name BuildStructureButton

extends Button


@onready var colony_ui: ColonyUI = $"../.."

@export var _structure_ghost: PackedScene

func _ready() -> void:
	pressed.connect(_on_pressed)

func _on_pressed() -> void:
	colony_ui.structure_placer.set_structure_ghost(_structure_ghost)
