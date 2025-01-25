class_name ProductionBalance

extends Resource
 
@export var products : Array[Production]
@export var requirement : ResourceRequirement

func produces_energy()->bool:
	for prod in products:
		if prod.type == Resources.type.ENERGY:
			return true
	return false
