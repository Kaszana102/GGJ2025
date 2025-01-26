extends Node

func set_active(state: bool):
	print("active: ", state)
	
	for child in get_children():
		print(child)
		if child is Light3D:
			print("HEJ")
			if state:
				child.light_color = Color.WHITE
			else:
				child.light_color = Color.BLACK
