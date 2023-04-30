extends Node3D

@onready
var sound_dict = {
	"low": {
		"neutral": [ preload("res://Gibberish/Clipped/Wah/Wah Clipped 1.wav"), preload("res://Gibberish/Clipped/Li/Li Clipped 1.wav"), preload("res://Gibberish/Clipped/Weh/Weh Clipped 1.wav"), preload("res://Gibberish/Clipped/Toh/Toh Clipped 1.wav") ],
		"rising": [ preload("res://Gibberish/Clipped/Wah/Wah Clipped 2.wav"), preload("res://Gibberish/Clipped/Li/Li Clipped 2.wav"), preload("res://Gibberish/Clipped/Weh/Weh Clipped 2.wav"), preload("res://Gibberish/Clipped/Toh/Toh Clipped 2.wav") ],
		"falling": [ preload("res://Gibberish/Clipped/Wah/Wah Clipped 3.wav"), preload("res://Gibberish/Clipped/Li/Li Clipped 3.wav"), preload("res://Gibberish/Clipped/Weh/Weh Clipped 3.wav"), preload("res://Gibberish/Clipped/Toh/Toh Clipped 3.wav") ]
	},
	"medium": {
		"neutral": [ preload("res://Gibberish/Clipped/Wah/Wah Clipped 4.wav"), preload("res://Gibberish/Clipped/Li/Li Clipped 4.wav"), preload("res://Gibberish/Clipped/Weh/Weh Clipped 4.wav"), preload("res://Gibberish/Clipped/Toh/Toh Clipped 4.wav") ],
		"rising": [ preload("res://Gibberish/Clipped/Wah/Wah Clipped 5.wav"), preload("res://Gibberish/Clipped/Li/Li Clipped 5.wav"), preload("res://Gibberish/Clipped/Weh/Weh Clipped 5.wav"), preload("res://Gibberish/Clipped/Toh/Toh Clipped 5.wav") ],
		"falling": [ preload("res://Gibberish/Clipped/Wah/Wah Clipped 6.wav"), preload("res://Gibberish/Clipped/Li/Li Clipped 6.wav"), preload("res://Gibberish/Clipped/Weh/Weh Clipped 6.wav"), preload("res://Gibberish/Clipped/Toh/Toh Clipped 6.wav") ]
	},
	"high": {
		"neutral": [ preload("res://Gibberish/Clipped/Wah/Wah Clipped 7.wav"), preload("res://Gibberish/Clipped/Li/Li Clipped 7.wav"), preload("res://Gibberish/Clipped/Weh/Weh Clipped 7.wav"), preload("res://Gibberish/Clipped/Toh/Toh Clipped 7.wav")],
		"rising": [ preload("res://Gibberish/Clipped/Wah/Wah Clipped 8.wav"), preload("res://Gibberish/Clipped/Li/Li Clipped 8.wav"), preload("res://Gibberish/Clipped/Weh/Weh Clipped 8.wav"), preload("res://Gibberish/Clipped/Toh/Toh Clipped 8.wav")],
		"falling": [ preload("res://Gibberish/Clipped/Wah/Wah Clipped 9.wav"), preload("res://Gibberish/Clipped/Li/Li Clipped 9.wav"), preload("res://Gibberish/Clipped/Weh/Weh Clipped 9.wav"), preload("res://Gibberish/Clipped/Toh/Toh Clipped 9.wav") ]
	}
}

@onready
var audio_emitter: AudioStreamPlayer3D = get_node("AudioStreamPlayer3D")

var random = RandomNumberGenerator.new()

var num_lines = 25
var current_line = 0
var step = 0

var context = {
	"baseline": 0,
	"target": 1,
	"length": 10,
	"tempo": 1.0
}

func _ready():
	random.randomize()

func _process(delta):
	if !audio_emitter.playing:
		var line_finished = play_next_sound(context, step)
		step += 1
		
		if line_finished:
			step = 0
			current_line += 1

	if current_line >= num_lines:
		pass #win I guess
		
func play_next_sound(context, step):
	if step < context["length"]:
		play_mouth_noise(get_keys(context, step))
		return false
	return true

func get_keys(context, step):
	var baseline = context["baseline"]
	var target = context["target"]
	var length = context["length"]
	
	var level = ""
	var transition = ""

	var num_divisions = abs(target - baseline)
	if num_divisions == 0:
		level = index_to_level(0)
		transition = "neutral"
	elif num_divisions == 1:
		if step < floor(length / 2):
			level = index_to_level(baseline)
			transition = "neutral"
		elif step == floor(length / 2):
			level = index_to_level(baseline)
			transition = "rising" if sign(target - baseline) > 0 else "falling"
		else:
			level = index_to_level(target)
			transition = "neutral"
	elif num_divisions == 2:
		pass
		
	return [level, transition]

func index_to_level(index):
	match index:
		0: return "low"
		1: return "medium"
		2: return "high"
	
func play_mouth_noise(keys):
	var level = keys[0]
	var transition = keys[1]
	print(level, transition)
	audio_emitter.stream = sound_dict[level][transition][random.randi_range(0, 2)]
	audio_emitter.pitch_scale = random.randf_range(0.8, 1.2)
	audio_emitter.volume_db = random.randf_range(-2, 2)
	audio_emitter.play(0.0)
