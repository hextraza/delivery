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

var hand_health := 1.0
var hand_health_cooldown_timer := 0.0
var last_clap_intensity := 0.0

const CLAP_INTENSITY = 1
var self_shake_amount := 0
var external_shake_amount := 0

func _process(delta):
	hands_skeleton.transform.origin = lerp(hands_skeleton.transform.origin, target_transform.origin, 0.3)
	hands_skeleton.transform.basis = lerp(hands_skeleton.transform.basis, target_transform.basis, 0.3)
	clap_audio_stream.transform.origin = hands_skeleton.transform.origin
	
	camera.rotation_degrees.y = controls.look_yaw
	camera.rotation_degrees.x = controls.look_pitch
	
	if hand_health < 1:
		var hand_shake_amount: float = remap(1 - abs(hand_health), 0.0, 1.0, 0.0, 20.0) * delta
		var dx: float = hand_shake_amount * rng.randf()
		var dy: float = hand_shake_amount * rng.randf()
		var dz: float = hand_shake_amount * rng.randf()
		hands_skeleton.position += Vector3(dx, dy, dz)
	
	if hand_health_cooldown_timer == 0.0:
		hand_health = clampf(hand_health + (delta * 0.015 * remap(last_clap_intensity, 0.0, 1.0, 0.25, 1.5)), 0.0, 1.0)
	else:
		hand_health_cooldown_timer = max(hand_health_cooldown_timer - delta, 0.0)
		
	_handle_screen_shake()
		
	if controls.get_just_clapped() && hand_health > 0.0:
		anim_player.current_animation = "clap"
	
	if clap_sound_activated:
		if anim_player.current_animation_position < 0.34 || is_equal_approx(anim_player.current_animation_position, anim_player.current_animation_length):
			clap_sound_activated = false

			if hand_health < 0:
				hand_health_cooldown_timer = 4.0
			else:
				hand_health_cooldown_timer = 1.2
			
			stop_self_screen_shake()
			
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
			last_clap_intensity = intensity
			hand_health -= remap(intensity, 0.0, 1.0, 1.0, 2.5) * 0.0055
			
			start_self_screen_shake()

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

func kill():
	add_external_screen_shake(200)

func _handle_screen_shake():
	var amount = self_shake_amount + external_shake_amount
	
	if amount != 0:
		camera.set_fov(75 + (amount * rng.randf_range(-1, 1)))
		camera.set_v_offset(amount / 100.0 * rng.randf_range(-1, 1))
		camera.set_h_offset(amount / 100.0 * rng.randf_range(-1, 1))
	else:
		camera.set_fov(75)
		camera.set_v_offset(0)
		camera.set_h_offset(0)


func start_self_screen_shake():
	self_shake_amount = intensity * 2


func stop_self_screen_shake():
	self_shake_amount = 0


func is_self_shaking():
	return self_shake_amount != 0


func add_external_screen_shake(amount = 1):
	external_shake_amount += amount


func subtract_external_screen_shake(amount = 1):
	external_shake_amount -= amount
	if external_shake_amount < 0:
		external_shake_amount = 0
