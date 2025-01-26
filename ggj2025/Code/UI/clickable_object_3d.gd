class_name ClickableObject3D

extends Area3D

signal clicked

func _input_event(camera: Camera3D, event: InputEvent, event_position: Vector3, normal: Vector3, shape_idx: int) -> void:
	# forgive me for this spaghetti pls
	var click_event := event as InputEventMouseButton
	if click_event and click_event.button_index == 1 and click_event.pressed:
		clicked.emit()
		print("it is I, a Clickable Object. Henceforth I have been CLICKED")
