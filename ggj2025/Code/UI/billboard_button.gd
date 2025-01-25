class_name Billboard

extends Node3D

## THE BEST CUSTOM BILLBOARD EVER

@export var fixed_size: bool = true

var _camera : RaycastCamera3D
var _initial_scale: Vector3

func _ready() -> void:
	_camera = get_viewport().get_camera_3d()
	_initial_scale = scale

func _process(delta: float) -> void:
	rotation = _camera.rotation
	
	if fixed_size:
		var local_position = _camera.to_local(position)  # position relative to camera local space
		scale = _initial_scale * -local_position.z
