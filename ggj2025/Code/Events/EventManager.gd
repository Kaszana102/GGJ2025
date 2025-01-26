class_name EventManager
extends Node

const resource_path = "res://Resources/Events/"
var events: Array [GameEvent]
var queued_event: GameEvent
var timer: Timer
const  min_time_between_events: float = 60.0
const  max_time_between_events: float = 180.0
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# Load events
	var dir = DirAccess.open(resource_path)
	if  dir:
		for filename in dir.get_files():
			print("found event file")
			events.push_back(ResourceLoader.load(resource_path+filename))
	else:
		print("failed to open resource directory")
	for event in events:
		event.doesitwork()
	# Set up event timer
	timer = Timer.new()
	add_child(timer)
	timer.wait_time = 10.0 # wait time in seconds
	timer.one_shot = true
	timer.start()
	timer.connect("timeout", _on_timer_timeout.bind(),0 )

func _on_timer_timeout() -> void:
	timer.wait_time = randf_range(min_time_between_events, max_time_between_events)
	# TODO : pick random event from available ones
	queued_event = events[0]

func consume_event() -> void:
	if events.find(queued_event) != -1:
		events.remove_at(events.find(queued_event))
	timer.start()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


# TODO :
# Loading events on start - done
# Random timer for events - done
# Draw events from the ones that can occur (predicate)
# Discard events that happened - done
# Event choices 
# GUI
