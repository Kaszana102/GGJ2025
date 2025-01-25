class_name BuildStructureButton

extends Button


@onready var colony_ui: ColonyUI = $"../.."

@export var _structure_ghost: PackedScene

func _ready() -> void:
	pressed.connect(_on_pressed)

func _on_pressed() -> void:
	if colony_ui.structure_placer.has_structure_ghost():
		colony_ui.structure_placer.clear_structure_ghost()
	else:
		colony_ui.structure_placer.set_structure_ghost(_structure_ghost)
