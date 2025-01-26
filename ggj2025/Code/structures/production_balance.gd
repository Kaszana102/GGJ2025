class_name ProductionBalance

extends Resource
 
@export var products : Array[Production] = []
@export var requirement : ResourceRequirement

## not calucalting time frame
func produced_energy()->float:
	for prod in products:
		if prod.type == Resources.type.ENERGY:
			return prod.amount
	return 0
