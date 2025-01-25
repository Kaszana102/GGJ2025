extends Structure


## produces resource in given delta time
## doesn consume energy, as it is calculated in gamemanager already
func produce(delta: float):
	if produced_resource_amount == 0:
		return 0	
	
	
	
	var produced_amount = ore_deposit.mine(produced_resource_amount * delta)
	GameManager.add_resource(
		produced_resource_type,
		produced_amount
	)
