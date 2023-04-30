extends Node3D

@onready var controls := $Controls as Controls
@onready var camera := $Camera as Camera3D
@onready var hands_skeleton := $hands/metarig/Skeleton3D as Skeleton3D
@onready var anim_player := $hands/AnimationPlayer as AnimationPlayer
@onready var hand_height_path := $hands/intensity_height as Path3D
@onready var clap_audio_stream := $hands/clap as AudioStreamPlayer3D
@onready var claps := {
	"0": [
		preload("res://Claps/Clap 1A.wav"),
		preload("res://Claps/Clap 1B.wav"),
		preload("res://Claps/Clap 1C.wav")
	],
	"0.25": [
		preload("res://Claps/Clap 2A.wav"),
		preload("res://Claps/Clap 2B.wav"),
		preload("res://Claps/Clap 2C.wav"),
	],
	"0.5": [
		preload("res://Claps/Clap 3A.wav"),
		preload("res://Claps/Clap 3B.wav"),
		preload("res://Claps/Clap 3C.wav")
	],
	"0.75": [
		preload("res://Claps/Clap 4A.wav"),
		preload("res://Claps/Clap 4B.wav"),
		preload("res://Claps/Clap 4C.wav")
	],
	"1": [
		preload("res://Claps/Clap 5A.wav"),
		preload("res://Claps/Clap 5B.wav"),
		preload("res://Claps/Clap 5C.wav")
	]
}
@onready var target_transform := Transform3D(hand_height_path.curve.sample_baked_with_rotation(0.0))

var rng = RandomNumberGenerator.new()
var intensity := 0.0
var clap_sound_activated := false

func _process(delta):
	hands_skeleton.transform.origin = lerp(hands_skeleton.transform.origin, target_transform.origin, 0.3)
	hands_skeleton.transform.basis = lerp(hands_skeleton.transform.basis, target_transform.basis, 0.3)
	clap_audio_stream.transform.origin = hands_skeleton.transform.origin
	
	camera.rotation_degrees.y = controls.look_yaw
	camera.rotation_degrees.x = controls.look_pitch
		
	if controls.get_just_clapped():
		anim_player.current_animation = "clap"
	
	if clap_sound_activated:
		if anim_player.current_animation_position < 0.34:
			clap_sound_activated = false
			var random_sample = rng.randi_range(0, 2)
			if intensity == 0:
				clap_audio_stream.stream = claps["0"][random_sample]
			elif intensity <= 0.25:
				clap_audio_stream.stream = claps["0.25"][random_sample]
			elif intensity <= 0.5:
				clap_audio_stream.stream = claps["0.5"][random_sample]
			elif intensity <= 0.75:
				clap_audio_stream.stream = claps["0.75"][random_sample]
			else:
				clap_audio_stream.stream = claps["1"][random_sample]
			clap_audio_stream.pitch_scale = rng.randf_range(0.75, 1.25)
	else:
		if anim_player.current_animation != "" && anim_player.current_animation_position > 0.34:
			clap_audio_stream.play()
			clap_sound_activated = true

	process_intensity(controls.get_clap_strength())


func process_intensity(i: float):
	target_transform = hand_height_path.curve.sample_baked_with_rotation(i * hand_height_path.curve.get_baked_length())
	anim_player.speed_scale = remap(intensity, 0.0, 1.0, 5.0, 6.0)
	var random_sample = rng.randi_range(0, 2)
	
	if self.intensity != i:
		if intensity == 0:
			clap_audio_stream.stream = claps["0"][random_sample]
		elif intensity <= 0.25:
			clap_audio_stream.stream = claps["0.25"][random_sample]
		elif intensity <= 0.5:
			clap_audio_stream.stream = claps["0.5"][random_sample]
		elif intensity <= 0.75:
			clap_audio_stream.stream = claps["0.75"][random_sample]
		else:
			clap_audio_stream.stream = claps["1"][random_sample]
	clap_audio_stream.pitch_scale = rng.randf_range(0.75, 1.25)
	self.intensity = i
