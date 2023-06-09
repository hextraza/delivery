extends Node3D

var beaks = []
var timer = 0.0
var event_triggered = 0
var current_intensity = 0.0
var intensity_reactivity_threshold = 2.0
var delta_intensity = 0.0
var speaker_wants_applause = false
var speaker_wanted_applause = false
var delta_intensity_reset_acc = 0.0
var delta_intensity_reset_threshold = 4.0
var hunting_beaks = []
var passive_beaks = []

@onready
var speaker = get_tree().get_first_node_in_group("speaker")

@onready
var player = get_tree().get_first_node_in_group("player")

@onready
var controls = player.find_child("Controls")

@onready
var player_audio = player.find_child("hands").find_child("clap")

var random = RandomNumberGenerator.new()

func _ready():
	random.randomize()
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
		passive_beaks = beaks.duplicate()


func _process(delta):
	speaker_wants_applause = speaker.get_expecting_applause()
	
	if player_audio.playing == true:
		var vel = delta * 0.9 * get_clap_intensity_modifier(controls.get_clap_strength())
		
		if vel != 0.0:
			delta_intensity_reset_acc = 0.0
			current_intensity += vel
			delta_intensity += vel
	else:
		if delta_intensity >= 0.0:
			delta_intensity -= delta * 0.08
		else:
			delta_intensity = 0.0
			
		if current_intensity > 0.01:
			current_intensity -= delta * 0.1
		else:
			current_intensity = 0.01
	
	if delta_intensity >= 0.0:
		delta_intensity_reset_acc += delta
		
	if delta_intensity_reset_acc >= delta_intensity_reset_threshold:
		delta_intensity = 0.0
		delta_intensity_reset_acc = 0.0
		
	if delta_intensity >= intensity_reactivity_threshold:
		player.kill()
		
	var num_hunting = floor(delta_intensity / intensity_reactivity_threshold * len(beaks)) * 0.75
	partition_beaks(num_hunting)
		
	#print("current_intensity ", current_intensity)
	#print("delta_intensity ", delta_intensity)
	#print("delta_intensity_reset_acc ", delta_intensity_reset_acc, "\n")
		
	# REALLY REALLY BAD DO NOT DO THIS
	for beak in beaks:
		beak.set_intensity(ceil(current_intensity))
		
		if speaker_wants_applause != speaker_wanted_applause:
			beak.toggle_clap(speaker.get_silence_length())
			
		if beak in hunting_beaks:
			beak.stare_at_target(player, random.randi_range(1.0, 5.0))
			
	speaker_wanted_applause = speaker_wants_applause

func partition_beaks(num_hunting_beaks):
	var difference = num_hunting_beaks - hunting_beaks.size()
	
	if difference > 0:
		for _i in range(difference):
			if passive_beaks.size() == 0:
				break
			var beak = passive_beaks.pop_front()
			hunting_beaks.append(beak)
	elif difference < 0:
		for _i in range(-difference):
			if hunting_beaks.size() == 0:
				break
			var beak = hunting_beaks.pop_front()
			passive_beaks.append(beak)


func get_clap_intensity_modifier(value):
	match value:
		0.0: return 0.0
		0.25: return 0.3
		0.5: return 0.65
		0.75: return 0.75
		1.0: return 1.5
