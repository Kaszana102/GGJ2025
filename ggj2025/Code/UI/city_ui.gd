class_name CityUI

extends Node3D

signal toggle_power
signal build_farm
signal build_generator
signal build_coal
signal build_iron
signal build_terraform

var finest_italian_pasta : bool = false  # spaghetti

func _hide_node() -> void:
	set_process(false)
	hide()
	print("city ui hidden")
	finest_italian_pasta = false

func _show_node() -> void:
	set_process(true)
	show()
	print("city ui shown")
	finest_italian_pasta = false
	

func _toggle_power() -> void:
	toggle_power.emit()
	
func _build_farm():
	build_farm.emit()

func _build_coal():
	build_coal.emit()
	print("COAL A")
	
func _build_iron():
	build_iron.emit()
	
func _build_terraform():
	build_terraform.emit()

func _build_generator():
	build_generator.emit()

	
func _ready() -> void:
	_hide_node()
	
func _process(delta: float) -> void:
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
		if finest_italian_pasta:
			_hide_node()
	else:
		finest_italian_pasta = true


func _on_clickable_object_3d_clicked() -> void:
	pass # Replace with function body.
