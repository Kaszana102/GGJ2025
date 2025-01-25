class_name CameraMovement

extends Node

@export var zoom_speed: float = 10
@export var rotate_speed: float = 10
@export var pan_speed: float = 10
@export var fallback_cursor_depth = 10

var _camera: RaycastCamera3D
var _zoom_direction: int = 0
var _rotation_anchor: Vector3 = Vector3(0,0,0)
var _rmb_pressed: bool
var _lmb_pressed: bool
var _drag_requested: bool

func _ready() -> void:
	_camera = get_parent() as RaycastCamera3D


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if _drag_requested:
		_capture_mouse()
	else:
		_release_mouse()

	if _zoom_direction != 0:
		_camera.position += _camera.global_transform.basis.z * _zoom_direction * zoom_speed * delta
		_zoom_direction = 0
		
	if Input.is_key_pressed(KEY_E):
		_camera.rotate_y(rotate_speed * delta)
	
	if Input.is_key_pressed(KEY_Q):
		_camera.rotate_y(-rotate_speed * delta)
		
func _handle_orbit(delta_horizontal : float) -> void:
	var rotation_vector : Vector3 = _camera.position - _rotation_anchor
	var angle: float =  delta_horizontal * rotate_speed * get_process_delta_time()
	rotation_vector = rotation_vector.rotated(Vector3(0,1,0), angle)
	_camera.position = _rotation_anchor + rotation_vector
	_camera.look_at(_rotation_anchor)

func _handle_pan(delta : Vector2):
	var y_rotation: Vector3 = Vector3(_camera.global_basis.z.x,0,_camera.global_basis.z.z) 
	var angle: float = Vector3(0,0,1).signed_angle_to(y_rotation, Vector3(0,1,0))
	var translation : Vector3 = Vector3(delta.x,0,delta.y).rotated(Vector3(0,1,0), angle) 
	_camera.position += translation *  pan_speed * get_process_delta_time()


func _capture_mouse() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
func _release_mouse() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	
func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_WHEEL_UP and event.pressed:
			_zoom_direction = -1
		if event.button_index == MOUSE_BUTTON_WHEEL_DOWN and event.pressed:
			_zoom_direction = 1
		if event.button_index == MOUSE_BUTTON_RIGHT:
			_rmb_pressed = event.pressed
			_drag_requested = event.pressed
			if _camera.get_raycast_position() != null:
				print("setting anchor to to ", _camera.get_raycast_position())
				_rotation_anchor = _camera.get_raycast_position()
			else:
				print("raycast position null")
		if event.button_index == MOUSE_BUTTON_LEFT:
			_lmb_pressed = event.pressed
			_drag_requested = event.pressed
			
	if event is InputEventMouseMotion and _rmb_pressed:
		event = event as InputEventMouseMotion
		_handle_orbit(-event.screen_relative.x)
		
		
	if event is InputEventMouseMotion and _lmb_pressed:
		event = event as InputEventMouseMotion
		_handle_pan(-event.screen_relative)
