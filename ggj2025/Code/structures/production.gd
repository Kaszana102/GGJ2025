class_name Production

extends Resource

@export var type: Resources.type
## amount per second
@export var amount: float
	
static func construct(_type: Resources.type, _amount: float) -> Production:
	var resource : Production = Production.new()
	resource.type = _type
	resource.amount = _amount
	return resource
