extends Node3D


const CLAP_VOLUME_DELTA_TIME_DISTRIBUTION = 5.0
const CLAP_VOLUME_TIME_BIAS = 0.1

const CLAP_1A = preload("res://Claps/Clap 1A.wav")
const CLAP_1B = preload("res://Claps/Clap 1B.wav")
const CLAP_1C = preload("res://Claps/Clap 1C.wav")
const CLAP_2A = preload("res://Claps/Clap 2A.wav")
const CLAP_2B = preload("res://Claps/Clap 2B.wav")
const CLAP_2C = preload("res://Claps/Clap 2C.wav")
const CLAP_3A = preload("res://Claps/Clap 3A.wav")
const CLAP_3B = preload("res://Claps/Clap 3B.wav")
const CLAP_3C = preload("res://Claps/Clap 3C.wav")
const CLAP_4A = preload("res://Claps/Clap 4A.wav")
const CLAP_4B = preload("res://Claps/Clap 4B.wav")
const CLAP_4C = preload("res://Claps/Clap 4C.wav")
const CLAP_5A = preload("res://Claps/Clap 5A.wav")
const CLAP_5B = preload("res://Claps/Clap 5B.wav")
const CLAP_5C = preload("res://Claps/Clap 5C.wav")

@onready
var audio_emitter: AudioStreamPlayer3D = get_node("AudioStreamPlayer3D")

@onready var player := get_tree().get_first_node_in_group("player") as Node3D
@onready var speaker := get_tree().get_first_node_in_group("speaker") as Node3D
@onready var beak := $beak as Node3D
@onready var beak_head := $beak/Head as Node3D
@onready var eye_right := $eye_right as Node3D
@onready var eye_left := $eye_left as Node3D
@onready var animation_tree := $beak/AnimationTree as AnimationTree
@onready var animation := $beak/AnimationTree.get("parameters/playback") as AnimationNodeStateMachinePlayback
@onready var bass_stare := $bass_stare as AudioStreamPlayer3D

var clapping = false
var clap_speed = 0.0
var clap_speed_acc = 0.0
var begin_clap_threshold = 0.0
var clap_intensity = 1
var num_claps = 0
var clap_length = 0.0
var clap_len_acc = 0.0
var bass_sound_mutex = false

@onready var look_target := speaker
@onready var look_actual := speaker.global_position

var random = RandomNumberGenerator.new()

func _ready():
	random.randomize()
	var right_position := eye_right.global_position
	var left_position := eye_left.global_position
	eye_right.reparent(beak_head)
	eye_left.reparent(beak_head)
	eye_right.global_position = right_position
	eye_left.global_position = left_position
	beak_head.look_at(speaker.global_position)
	animation.travel("Idle")
	bass_stare.pitch_scale = random.randf_range(0.5, 1.5)

func _process(delta):
	look_actual = lerp(look_actual, look_target.global_position, 2.0 * delta)
	beak_head.look_at(look_actual)
		
	clap_len_acc += delta

	if !clapping || clap_len_acc >= clap_length:
		animation.travel("Idle")
		return
		
	if clap_speed_acc >= begin_clap_threshold && begin_clap_threshold != 0.0:
		begin_clap_threshold = 0.0
		clap_speed_acc = 0.0
	else:
		clap_speed_acc += delta
	
	if !audio_emitter.playing && clapping && begin_clap_threshold == 0.0:
		clap_speed_acc += delta
		
		if clap_speed_acc >= clap_speed:
			num_claps += 1
			audio_emitter.stream = get_clap_stream()
			audio_emitter.pitch_scale = random.randf_range(0.9, 1.2)
			audio_emitter.volume_db = random.randf_range(-10, 2)
			clap_speed_acc = 0.0
			animation.travel("Clap")
			audio_emitter.play(0.0)

func toggle_clap(avg_len):
	animation.travel("ClapWaiting")
	clapping = !clapping
	clap_speed = random.randf_range(0.4, 1.0) / clap_intensity
	begin_clap_threshold = random.randf_range(0.0, 3.0) * clap_speed + random.randf_range(0.0, 15.0)
	num_claps = 0
	clap_len_acc = 0.0
	
	if clapping:
		clap_length = avg_len * random.randf_range(0.65, 0.95)
	else:
		clap_length = 0

func set_intensity(value):
	clap_intensity = value
	
func get_clap_stream():
	var i = random.randi_range(1, 3)
	
	if clap_intensity == 1:
		if i == 1:
			return CLAP_1A
		elif i == 2:
			return CLAP_1B
		elif i == 3:
			return CLAP_1C
	elif clap_intensity == 2:
		if i == 1:
			return CLAP_2A
		elif i == 2:
			return CLAP_2B
		elif i == 3:
			return CLAP_2C
	elif clap_intensity == 3:
		if i == 1:
			return CLAP_3A
		elif i == 2:
			return CLAP_3B
		elif i == 3:
			return CLAP_3C
	elif clap_intensity == 4:
		if i == 1:
			return CLAP_4A
		elif i == 2:
			return CLAP_4B
		elif i == 3:
			return CLAP_4C
	elif clap_intensity == 5:
		if i == 1:
			return CLAP_5A
		elif i == 2:
			return CLAP_5B
		elif i == 3:
			return CLAP_5C
			
func stare_at_target(target: Node3D, time: float):
	look_target = target
	if bass_sound_mutex == false:
		bass_stare.play()
		bass_sound_mutex = true
		await get_tree().create_timer(time).timeout
		bass_stare.stop()
		look_target = speaker
		bass_sound_mutex = false
