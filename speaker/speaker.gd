extends Node3D

@onready
var sound_dict = {
	"low": {
		"neutral": [ preload("res://Gibberish/Clipped/Am/Am Clipped 1.wav"), preload("res://Gibberish/Clipped/Chi/Chi Clipped 1.wav"), preload("res://Gibberish/Clipped/Eel/Eel Clipped 1.wav"), preload("res://Gibberish/Clipped/Ehv/Ehv Clipped 1.wav"), preload("res://Gibberish/Clipped/Li/Li Clipped 1.wav"), preload("res://Gibberish/Clipped/Loh/Loh Clipped 1.wav"), preload("res://Gibberish/Clipped/Meh/Meh Clipped 1.wav"), preload("res://Gibberish/Clipped/Mi/Mi Clipped 1.wav"), preload("res://Gibberish/Clipped/Ob/Ob Clipped 1.wav"), preload("res://Gibberish/Clipped/Saeu/Saeu Clipped 1.wav"), preload("res://Gibberish/Clipped/Tah/Tah Clipped 1.wav"), preload("res://Gibberish/Clipped/Toh/Toh Clipped 1.wav"), preload("res://Gibberish/Clipped/Voh/Voh Clipped 1.wav"), preload("res://Gibberish/Clipped/Wah/Wah Clipped 1.wav"), preload("res://Gibberish/Clipped/Weh/Weh Clipped 1.wav"), preload("res://Gibberish/Clipped/Wi/Wi Clipped 1.wav") ],
		"rising": [ preload("res://Gibberish/Clipped/Am/Am Clipped 2.wav"), preload("res://Gibberish/Clipped/Chi/Chi Clipped 2.wav"), preload("res://Gibberish/Clipped/Eel/Eel Clipped 2.wav"), preload("res://Gibberish/Clipped/Ehv/Ehv Clipped 2.wav"), preload("res://Gibberish/Clipped/Li/Li Clipped 2.wav"), preload("res://Gibberish/Clipped/Loh/Loh Clipped 2.wav"), preload("res://Gibberish/Clipped/Meh/Meh Clipped 2.wav"), preload("res://Gibberish/Clipped/Mi/Mi Clipped 2.wav"), preload("res://Gibberish/Clipped/Ob/Ob Clipped 2.wav"), preload("res://Gibberish/Clipped/Saeu/Saeu Clipped 2.wav"), preload("res://Gibberish/Clipped/Tah/Tah Clipped 2.wav"), preload("res://Gibberish/Clipped/Toh/Toh Clipped 2.wav"), preload("res://Gibberish/Clipped/Voh/Voh Clipped 2.wav"), preload("res://Gibberish/Clipped/Wah/Wah Clipped 2.wav"), preload("res://Gibberish/Clipped/Weh/Weh Clipped 2.wav"), preload("res://Gibberish/Clipped/Wi/Wi Clipped 2.wav") ],
		"falling": [ preload("res://Gibberish/Clipped/Am/Am Clipped 3.wav"), preload("res://Gibberish/Clipped/Chi/Chi Clipped 3.wav"), preload("res://Gibberish/Clipped/Eel/Eel Clipped 3.wav"), preload("res://Gibberish/Clipped/Ehv/Ehv Clipped 3.wav"), preload("res://Gibberish/Clipped/Li/Li Clipped 3.wav"), preload("res://Gibberish/Clipped/Loh/Loh Clipped 3.wav"), preload("res://Gibberish/Clipped/Meh/Meh Clipped 3.wav"), preload("res://Gibberish/Clipped/Mi/Mi Clipped 3.wav"), preload("res://Gibberish/Clipped/Ob/Ob Clipped 3.wav"), preload("res://Gibberish/Clipped/Saeu/Saeu Clipped 3.wav"), preload("res://Gibberish/Clipped/Tah/Tah Clipped 3.wav"), preload("res://Gibberish/Clipped/Toh/Toh Clipped 3.wav"), preload("res://Gibberish/Clipped/Voh/Voh Clipped 3.wav"), preload("res://Gibberish/Clipped/Wah/Wah Clipped 3.wav"), preload("res://Gibberish/Clipped/Weh/Weh Clipped 3.wav"), preload("res://Gibberish/Clipped/Wi/Wi Clipped 3.wav") ]
	},
	"medium": {
		"neutral": [ preload("res://Gibberish/Clipped/Am/Am Clipped 4.wav"), preload("res://Gibberish/Clipped/Chi/Chi Clipped 4.wav"), preload("res://Gibberish/Clipped/Eel/Eel Clipped 4.wav"), preload("res://Gibberish/Clipped/Ehv/Ehv Clipped 4.wav"), preload("res://Gibberish/Clipped/Li/Li Clipped 4.wav"), preload("res://Gibberish/Clipped/Loh/Loh Clipped 4.wav"), preload("res://Gibberish/Clipped/Meh/Meh Clipped 4.wav"), preload("res://Gibberish/Clipped/Mi/Mi Clipped 4.wav"), preload("res://Gibberish/Clipped/Ob/Ob Clipped 4.wav"), preload("res://Gibberish/Clipped/Saeu/Saeu Clipped 4.wav"), preload("res://Gibberish/Clipped/Tah/Tah Clipped 4.wav"), preload("res://Gibberish/Clipped/Toh/Toh Clipped 4.wav"), preload("res://Gibberish/Clipped/Voh/Voh Clipped 4.wav"), preload("res://Gibberish/Clipped/Wah/Wah Clipped 4.wav"), preload("res://Gibberish/Clipped/Weh/Weh Clipped 4.wav"), preload("res://Gibberish/Clipped/Wi/Wi Clipped 4.wav") ],
		"rising": [ preload("res://Gibberish/Clipped/Am/Am Clipped 5.wav"), preload("res://Gibberish/Clipped/Chi/Chi Clipped 5.wav"), preload("res://Gibberish/Clipped/Eel/Eel Clipped 5.wav"), preload("res://Gibberish/Clipped/Ehv/Ehv Clipped 5.wav"), preload("res://Gibberish/Clipped/Li/Li Clipped 5.wav"), preload("res://Gibberish/Clipped/Loh/Loh Clipped 5.wav"), preload("res://Gibberish/Clipped/Meh/Meh Clipped 5.wav"), preload("res://Gibberish/Clipped/Mi/Mi Clipped 5.wav"), preload("res://Gibberish/Clipped/Ob/Ob Clipped 5.wav"), preload("res://Gibberish/Clipped/Saeu/Saeu Clipped 5.wav"), preload("res://Gibberish/Clipped/Tah/Tah Clipped 5.wav"), preload("res://Gibberish/Clipped/Toh/Toh Clipped 5.wav"), preload("res://Gibberish/Clipped/Voh/Voh Clipped 5.wav"), preload("res://Gibberish/Clipped/Wah/Wah Clipped 5.wav"), preload("res://Gibberish/Clipped/Weh/Weh Clipped 5.wav"), preload("res://Gibberish/Clipped/Wi/Wi Clipped 5.wav") ],
		"falling": [ preload("res://Gibberish/Clipped/Am/Am Clipped 6.wav"), preload("res://Gibberish/Clipped/Chi/Chi Clipped 6.wav"), preload("res://Gibberish/Clipped/Eel/Eel Clipped 6.wav"), preload("res://Gibberish/Clipped/Ehv/Ehv Clipped 6.wav"), preload("res://Gibberish/Clipped/Li/Li Clipped 6.wav"), preload("res://Gibberish/Clipped/Loh/Loh Clipped 6.wav"), preload("res://Gibberish/Clipped/Meh/Meh Clipped 6.wav"), preload("res://Gibberish/Clipped/Mi/Mi Clipped 6.wav"), preload("res://Gibberish/Clipped/Ob/Ob Clipped 6.wav"), preload("res://Gibberish/Clipped/Saeu/Saeu Clipped 6.wav"), preload("res://Gibberish/Clipped/Tah/Tah Clipped 6.wav"), preload("res://Gibberish/Clipped/Toh/Toh Clipped 6.wav"), preload("res://Gibberish/Clipped/Voh/Voh Clipped 6.wav"), preload("res://Gibberish/Clipped/Wah/Wah Clipped 6.wav"), preload("res://Gibberish/Clipped/Weh/Weh Clipped 6.wav"), preload("res://Gibberish/Clipped/Wi/Wi Clipped 6.wav") ]
	},
	"high": {
		"neutral": [ preload("res://Gibberish/Clipped/Am/Am Clipped 7.wav"), preload("res://Gibberish/Clipped/Chi/Chi Clipped 7.wav"), preload("res://Gibberish/Clipped/Eel/Eel Clipped 7.wav"), preload("res://Gibberish/Clipped/Ehv/Ehv Clipped 7.wav"), preload("res://Gibberish/Clipped/Li/Li Clipped 7.wav"), preload("res://Gibberish/Clipped/Loh/Loh Clipped 7.wav"), preload("res://Gibberish/Clipped/Meh/Meh Clipped 7.wav"), preload("res://Gibberish/Clipped/Mi/Mi Clipped 7.wav"), preload("res://Gibberish/Clipped/Ob/Ob Clipped 7.wav"), preload("res://Gibberish/Clipped/Saeu/Saeu Clipped 7.wav"), preload("res://Gibberish/Clipped/Tah/Tah Clipped 7.wav"), preload("res://Gibberish/Clipped/Toh/Toh Clipped 7.wav"), preload("res://Gibberish/Clipped/Voh/Voh Clipped 7.wav"), preload("res://Gibberish/Clipped/Wah/Wah Clipped 7.wav"), preload("res://Gibberish/Clipped/Weh/Weh Clipped 7.wav"), preload("res://Gibberish/Clipped/Wi/Wi Clipped 7.wav") ],
		"rising": [ preload("res://Gibberish/Clipped/Am/Am Clipped 8.wav"), preload("res://Gibberish/Clipped/Chi/Chi Clipped 8.wav"), preload("res://Gibberish/Clipped/Eel/Eel Clipped 8.wav"), preload("res://Gibberish/Clipped/Ehv/Ehv Clipped 8.wav"), preload("res://Gibberish/Clipped/Li/Li Clipped 8.wav"), preload("res://Gibberish/Clipped/Loh/Loh Clipped 8.wav"), preload("res://Gibberish/Clipped/Meh/Meh Clipped 8.wav"), preload("res://Gibberish/Clipped/Mi/Mi Clipped 8.wav"), preload("res://Gibberish/Clipped/Ob/Ob Clipped 8.wav"), preload("res://Gibberish/Clipped/Saeu/Saeu Clipped 8.wav"), preload("res://Gibberish/Clipped/Tah/Tah Clipped 8.wav"), preload("res://Gibberish/Clipped/Toh/Toh Clipped 8.wav"), preload("res://Gibberish/Clipped/Voh/Voh Clipped 8.wav"), preload("res://Gibberish/Clipped/Wah/Wah Clipped 8.wav"), preload("res://Gibberish/Clipped/Weh/Weh Clipped 8.wav"), preload("res://Gibberish/Clipped/Wi/Wi Clipped 8.wav") ],
		"falling": [ preload("res://Gibberish/Clipped/Am/Am Clipped 9.wav"), preload("res://Gibberish/Clipped/Chi/Chi Clipped 9.wav"), preload("res://Gibberish/Clipped/Eel/Eel Clipped 9.wav"), preload("res://Gibberish/Clipped/Ehv/Ehv Clipped 9.wav"), preload("res://Gibberish/Clipped/Li/Li Clipped 9.wav"), preload("res://Gibberish/Clipped/Loh/Loh Clipped 9.wav"), preload("res://Gibberish/Clipped/Meh/Meh Clipped 9.wav"), preload("res://Gibberish/Clipped/Mi/Mi Clipped 9.wav"), preload("res://Gibberish/Clipped/Ob/Ob Clipped 9.wav"), preload("res://Gibberish/Clipped/Saeu/Saeu Clipped 9.wav"), preload("res://Gibberish/Clipped/Tah/Tah Clipped 9.wav"), preload("res://Gibberish/Clipped/Toh/Toh Clipped 9.wav"), preload("res://Gibberish/Clipped/Voh/Voh Clipped 9.wav"), preload("res://Gibberish/Clipped/Wah/Wah Clipped 9.wav"), preload("res://Gibberish/Clipped/Weh/Weh Clipped 9.wav"), preload("res://Gibberish/Clipped/Wi/Wi Clipped 9.wav") ]
	}
}

@onready
var audio_emitter: AudioStreamPlayer3D = get_node("AudioStreamPlayer3D")

@onready
var player = get_tree().get_first_node_in_group("player")

@onready
var controls = player.find_child("Controls")

@onready
var player_audio = player.find_child("hands").find_child("clap")

@onready
var animation_tree = $speaker/AnimationTree as AnimationTree

@onready
var head_anim = animation_tree.get("parameters/Head Movement/playback") as AnimationNodeStateMachinePlayback

@onready
var mouth_anim = animation_tree.get("parameters/Lip Flaps/playback") as AnimationNodeStateMachinePlayback

@onready
var neutral_position = $"Neutral Position" as Node3D

@onready
var speaker = $speaker as Node3D

@onready
var right_eye = $speaker/eye_right as Node3D

@onready
var left_eye = $speaker/eye_left as Node3D

@onready
var breathing_samples := [
	preload("res://Whispers and Breathing/Heavy Breathing 1.wav"),
	preload("res://Whispers and Breathing/Heavy Breathing 2.wav"),
	preload("res://Whispers and Breathing/Heavy Breathing 3.wav"),
	preload("res://Whispers and Breathing/Heavy Breathing 4.wav")
]

@onready
var ears_ringing := $EarsRinging as AudioStreamPlayer

@onready
var heavy_breathing := $HeavyBreathing as AudioStreamPlayer

var random = RandomNumberGenerator.new()

var num_lines = 25
var current_line = 0
var step = 0
var silence = 0.0
var last_choice = -1
var player_rude_clap_threshold = 1.0
var player_expected_clap_threshold = 5.0
var player_clap_acc = 0.0
var applause_expected = false
var player_immune = false
var player_reset_acc = 0.0
var player_reset_threshold = 2.5
var silence_length = 0.0
var angry = false
var look_target: Vector3
var look_actual: Vector3
var prior_heavy_breathing_sample := 0
var stop_ringing := false

var context = {
	"baseline": 0,
	"target": 2,
	"length": 10,
	"tempo": 1.0,
	"difficulty_mod": 1.0
}

func _ready():
	random.randomize()
	head_anim.travel("Idle")
	mouth_anim.travel("Idle")
	print("change look target 80")
	change_look_target(to_global(-Vector3.FORWARD))
	look_actual = look_target

func set_clap_thresholds(level):
	match level:
		0:
			player_rude_clap_threshold = 1.3 * context["difficulty_mod"]
			player_expected_clap_threshold = 3.5 * context["difficulty_mod"]
		1:
			player_rude_clap_threshold = 1.5 * context["difficulty_mod"]
			player_expected_clap_threshold = 3.0 * context["difficulty_mod"]
		2:
			player_rude_clap_threshold = 1.7 * context["difficulty_mod"]
			player_expected_clap_threshold = 2.7 * context["difficulty_mod"]

func _process(delta):
	if silence > 0.0:
		silence -= delta
	else:
		silence = 0.0
		silence_length = 0.0
		
	if stop_ringing:
		if ears_ringing.volume_db < -40.0:
			ears_ringing.stop()
		else:
			ears_ringing.volume_db -= delta * 0.1
	
	var scale_amount = remap(player_clap_acc, 0.0, player_expected_clap_threshold, 0.1, 2.0)
	right_eye.scale = Vector3(scale_amount, scale_amount, scale_amount)
	left_eye.scale = Vector3(scale_amount, scale_amount, scale_amount)
	
	look_actual = lerp(look_actual, look_target, 4.0 * delta)
	speaker.look_at(look_actual)
	
	var new_sample = floor(remap(clamp(player_clap_acc, 0.0, player_rude_clap_threshold), 0.0, player_rude_clap_threshold, 0.0, 3.9))
	if new_sample != prior_heavy_breathing_sample:
		prior_heavy_breathing_sample = new_sample
		heavy_breathing.stream = breathing_samples[new_sample]
		heavy_breathing.play()
	
	heavy_breathing.volume_db = remap(player_clap_acc, 0.0, player_rude_clap_threshold, 1.0, 6.0)
	if angry == true:
		print(ears_ringing.volume_db)
		ears_ringing.volume_db = remap(clamp(player_clap_acc, 0.0, player_rude_clap_threshold), 0.0, player_rude_clap_threshold, -40.0, -1.0)
	else:
		ears_ringing.volume_db = clamp(ears_ringing.volume_db - (delta * 0.1), -40.0, 0.0)
	
	# Stare at player if they are approaching the rude threshold
	if player_clap_acc > (player_rude_clap_threshold * 0.5) && !applause_expected && angry == false:
		ears_ringing.play()
#		print("Anger and look at player 101")
		head_anim.travel("Anger")
#		print("change look target 109")
		change_look_target(player.global_position)
		angry = true

		
	print("applause_expected: ", applause_expected)
	print("player_expected_clap_threshold: ", player_expected_clap_threshold)
	print("player_rude_clap_threshold: ", player_rude_clap_threshold)
	print("player_acc: ", player_clap_acc)
	print("player_immune: ", player_immune, "\n")
		
	if player_audio.playing == true:
		player_clap_acc += delta * get_clap_intensity_modifier(controls.get_clap_strength())
		player_reset_acc = 0.0
	else:
		player_reset_acc += delta
		
		if player_reset_acc > player_reset_threshold && !player_immune:
			reset_clap_accumulator()
	
	
	if !audio_emitter.playing && silence <= 0.0:
		if applause_expected && !player_immune && !player.dead:
#			print("Angry 138")
			mouth_anim.travel("Idle")
			head_anim.travel("Angry")
			ears_ringing.volume_db = -1.0			
			ears_ringing.play()
			heavy_breathing.stop()
			player.kill() 
			await get_tree().create_timer(4.0).timeout
			stop_ringing = true
#			ears_ringing.stop()
		elif applause_expected:
			reset_clap_accumulator()
			
		if step == 0:
#			print("IdleTalking 146")
			head_anim.travel("IdleTalking")
			if angry == false:
#				print("change look target 158")
				change_look_target(to_global(-Vector3.FORWARD))
		
		player_immune = false
		applause_expected = false

		var result = play_next_sound(context, step)
		var line_finished = result[0]
		var step_diff = result[1]
		step += step_diff
		
		if line_finished:
			applause_expected = true
#			print("Idle 158")
#			print("change look target 170")
			change_look_target(player.global_position)
			head_anim.travel("Idle")
			step = 0
			current_line += 1
			
			silence_length = random.randf_range(5, 12)
			silence = silence_length
			
			context["baseline"] = random.randi_range(0, 2)
			context["target"] = random.randi_range(0, 2)
			context["length"] = random.randi_range(10, 25)
			context["tempo"] = random.randf_range(0.9, 1.2)
			context["difficulty_mod"] = random.randf_range(0.8, 1.2)

	if applause_expected && player_clap_acc >= player_expected_clap_threshold:
		head_anim.travel("Idle")
		player_immune = true
	elif !applause_expected && player_clap_acc >= player_rude_clap_threshold && !player.dead:
#		print("Angry 131")
		mouth_anim.travel("Idle")
		head_anim.travel("Angry")
		ears_ringing.volume_db = -1.0
		ears_ringing.play()
		heavy_breathing.stop()
		player.kill()
		await get_tree().create_timer(4.0).timeout
		stop_ringing = true
#		ears_ringing.stop()

	if current_line >= num_lines:
		await Fade.fade_out(5.0).finished
		get_tree().change_scene_to_file("res://win.tscn")
		
func play_next_sound(context, step):
	if random.randf() < 0.1:
		silence = random.randf_range(0.1, 2.0)
		
	if step < context["length"]:
		play_mouth_noise(get_keys(context, step))
		return [false, 1.0]
	return [true, 1.0]

func get_keys(context, step):
	var baseline = context["baseline"]
	var target = context["target"]
	var length = context["length"]
	
	var level = ""
	var transition = ""

	var num_divisions = abs(target - baseline)
	if num_divisions == 0:
		level = index_to_level(baseline)
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
		if step < floor(length / 3):
			level = index_to_level(baseline)
			transition = "neutral"
		elif step == floor(length / 3):
			level = index_to_level(baseline)
			transition = "rising" if sign(target - baseline) > 0 else "falling"
		elif step < floor((2 * length) / 3):
			level = index_to_level(2)
			transition = "neutral"
		elif step == floor((2 * length) / 3):
			level = index_to_level(2)
			transition = "rising" if sign(target - baseline) > 0 else "falling"
		else:
			level = index_to_level(target)
			transition = "neutral"
	
	return [level, transition]

func index_to_level(index):
	var current_level = ""
	match index:
		0: current_level = "low"
		1: current_level = "medium"
		2: current_level = "high"
		
	set_clap_thresholds(context["target"])
	return current_level

func play_mouth_noise(keys):
	var level = keys[0]
	var transition = keys[1]
	var choices = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15]

	if last_choice != -1:
		choices.erase(last_choice)

	var choice = choices[random.randi_range(0, len(choices) - 1)]

	last_choice = choice

	audio_emitter.stream = sound_dict[level][transition][choice]
	audio_emitter.pitch_scale = random.randf_range(0.95, 1.05)
	audio_emitter.volume_db = random.randf_range(-2, 2)
	mouth_anim.travel("LipFlap")
	audio_emitter.play(0.0)


func get_clap_intensity_modifier(value):
	match value:
		0.0: return 1.0
		0.25: return 1.3
		0.5: return 1.4
		0.75: return 1.5
		1.0: return 1.8
		
func get_expecting_applause():
	return applause_expected
	
func get_silence_length():
	return silence_length

func change_look_target(target: Vector3):
#	print("Target changed: ", target)
	look_target = target
	
func reset_clap_accumulator():
	player_clap_acc = 0.0
	player_reset_acc = 0.0
	if angry == true:
		angry = false
		ears_ringing.stop()
		if applause_expected:
#			print("Idle 122")
			head_anim.travel("Idle")
#			print("change look target 133")
			change_look_target(player.global_position)
		else:
#			print("Idle 139")
			head_anim.travel("Idle")
#			print("change look target 141")
			change_look_target(to_global(-Vector3.FORWARD))
