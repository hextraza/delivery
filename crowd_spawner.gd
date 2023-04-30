extends Node3D

var beaks = []
var timer = 0.0
var event_triggered = 0
var current_intensity = 0.0
var intensity_reactivity_threshold = 2.0
var delta_intensity = 0.0
var speaker_wants_applause = false
var speaker_wanted_applause = false

@onready
var speaker = get_tree().get_first_node_in_group("speaker")

@onready
var player = get_tree().get_first_node_in_group("player")

@onready
var controls = player.find_child("Controls")

@onready
var player_audio = player.find_child("hands").find_child("clap")

func _ready():
	var shift = false
	var children = self.get_children()
	
	for i in children.size():			
		var beak = load("res://beak/beak.tscn").instantiate()
		beak.position = children[i].position
		
		if shift:
			var pos = beak.position
			beak.position.x += 0.5
			
		if i % 27 == 0:
			shift = !shift
		
		add_child(beak)
		beaks.append(beak)


func _process(delta):
	speaker_wants_applause = speaker.get_expecting_applause()
	
	if player_audio.playing == true:
		current_intensity += delta * 0.8 * get_clap_intensity_modifier(controls.get_clap_strength())
	else:
		if current_intensity > 0.01:
			current_intensity -= delta * 0.1
		else:
			current_intensity = 0.01
	
	# REALLY REALLY BAD DO NOT DO THIS
	for beak in beaks:
		beak.set_intensity(ceil(current_intensity))
		
		if speaker_wants_applause != speaker_wanted_applause:
			beak.toggle_clap()
			
	speaker_wanted_applause = speaker_wants_applause
	


func get_clap_intensity_modifier(value):
	match value:
		0.0: return 0.0
		0.25: return 1.1
		0.5: return 1.2
		0.75: return 1.3
		1.0: return 1.5
