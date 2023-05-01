extends Node3D

@onready
var togon = preload("res://Sign Toggle On.wav")

@onready
var togoff = preload("res://Sign Toggle Off.wav")

@onready
var speaker = get_tree().get_first_node_in_group("speaker")

@onready
var light = self.find_child("SpotLight3D2")

@onready
var audio: AudioStreamPlayer3D = self.find_child("AudioStreamPlayer3D")

enum SignState {
	ON,
	OFF
}
var current_state = SignState.OFF


func _ready():
	pass


func _process(delta):
	if speaker.get_expecting_applause() and current_state == SignState.OFF:
		activate()
	elif !speaker.get_expecting_applause() and current_state == SignState.ON:
		deactivate()


func activate():
	current_state = SignState.ON
	
	audio.stream = togon
	audio.play(0.0)
	light.visible = true


func deactivate():
	current_state = SignState.OFF
	
	audio.stream = togoff
	audio.play(0.0)
	light.visible = false
