extends GameEvent

@export var production_requirements : EventResourceRequirements
@export var stockpile_requirements : EventResourceRequirements

func can_occur() -> bool :
	for key in stockpile_requirements.resources:
		if not GameManager.has_resource(key, stockpile_requirements[key]):
			return false
	# TODO: implement production requirements (game manager doesn't expose it directly)
	return true
