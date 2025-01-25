class_name Ore

extends Node3D

enum type {IRON, COAL}

@export var total_amount: float = 100
@export var ore_type: type = type.COAL

func mine(amount: float) -> float :
	if(total_amount>=amount):
		total_amount -= amount
		return amount
	else:
		var temp = total_amount
		total_amount = 0
		return temp
