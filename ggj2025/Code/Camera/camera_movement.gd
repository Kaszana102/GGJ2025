class_name CameraMovement

extends Node3D

@export var zoom_speed: float = 10
@export var rotate_speed: float = 10

var _camera: Node3D


func _ready() -> void:
	_camera = get_parent()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_released("MWU"):  # todo to nie działa napraw jutro D:<
		print("zoom")
		_camera.position.y += zoom_speed * delta
	
	if Input.is_action_just_released("ui_text_scroll_up"): # todo to nie działa
		print("zoom2")
		_camera.position.y -= zoom_speed * delta
	
	if Input.is_key_pressed(KEY_E):
		_camera.rotate_y(rotate_speed * delta)
	
	if Input.is_key_pressed(KEY_Q):
		_camera.rotate_y(-rotate_speed * delta)
