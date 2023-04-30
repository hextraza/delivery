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

func _ready():
	pass

func _process(delta):
	if speaker.get_expecting_applause():
		activate()
	else:
		deactivate()
	
	
func activate():
	audio.stream = togon
	audio.volume_db = 2
	audio.play(0.0)
	light.visible = true
	
func deactivate():
	audio.stream = togoff
	audio.volume_db = 3
	audio.play(0.0)
	light.visible = false
