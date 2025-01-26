class_name BlackOutUI

extends HBoxContainer

var blackout_status_label
@export var turn_on_audio_source: AudioStreamPlayer

func _init() -> void:
	blackout_status_label = Label.new()
	blackout_status_label.text = "Power on"
	
	var restart_blackout = Button.new()
	restart_blackout.text = "Turn on power"
	restart_blackout.connect("pressed",reset_blackout)
	
	
	add_child(blackout_status_label)
	add_child(restart_blackout)
	# TODO add some const size of this container

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	blackout_status_label.text = (
	 	"Power off" if GameManager._blackout else "Power on"
	)
	if GameManager._blackout and turn_on_audio_source.playing:
		turn_on_audio_source.stop()

func reset_blackout():
	GameManager._blackout=false
	turn_on_audio_source.play()
	pass
