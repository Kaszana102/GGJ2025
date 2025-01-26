class_name Production

extends Resource

@export var type: Resources.type
## amount per second
@export var amount: float
	
static func construct(type: Resources.type, amount: float) -> Resource:
	var resource : Resource = Resource.new()
	resource.type = type
	resource.amount = amount
	return resource
