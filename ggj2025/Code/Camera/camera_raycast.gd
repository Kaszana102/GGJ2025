class_name RaycastCamera3D

extends Camera3D

@export var raycast_indicator: Node3D
@export var ray_length: float = 100


## Returns either [Vector3] or [code]null[/code]
func get_raycast_position(): # -> Vector3:
	var mouse_pos = get_viewport().get_mouse_position()
	var space = get_world_3d().direct_space_state
	
	var ray_query = PhysicsRayQueryParameters3D.new()
	ray_query.from = project_ray_origin(mouse_pos)
	ray_query.to = ray_query.from + project_ray_normal(mouse_pos) * ray_length
	ray_query.collide_with_areas = true
	
	var raycast_position = space.intersect_ray(ray_query).get("position")
	if raycast_position:
		return raycast_position
		
	return null

## Todo, only for debug, remove this
func _process(delta: float) -> void:
	var pos = get_raycast_position()
	if pos:
		raycast_indicator.position = pos
	
