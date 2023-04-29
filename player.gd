extends Node3D

@onready var controls := $Controls as Controls
@onready var camera := $Camera as Camera3D
@onready var arms := $Arms as Node3D
@onready var hands := $Arms/Hands as Node3D
@onready var hands_skeleton := $hands/metarig/Skeleton3D as Skeleton3D
@onready var anim_player := $hands/AnimationPlayer as AnimationPlayer
@onready var hand_height_path := $hands/intensity_height as Path3D

var is_clapping := false
@onready var target_transform := Transform3D(hand_height_path.curve.sample_baked_with_rotation(0.0))

func _ready():
	anim_player.get_animation("clap").loop_mode = Animation.LOOP_LINEAR

func _process(delta):
	hands_skeleton.transform.origin = lerp(hands_skeleton.transform.origin, target_transform.origin, 0.3)
	hands_skeleton.transform.basis = lerp(hands_skeleton.transform.basis, target_transform.basis, 0.3)
	
	if is_clapping:
		if controls.get_stopped_clapping():
			is_clapping = false
			anim_player.current_animation = "[stop]"
	else:
		if controls.get_just_clapped():
			is_clapping = true
			anim_player.current_animation = "clap"
			anim_player
	process_intensity(controls.get_clap_strength())


func process_intensity(intensity: float):
	target_transform = hand_height_path.curve.sample_baked_with_rotation(intensity * hand_height_path.curve.get_baked_length())
	anim_player.speed_scale = remap(intensity, 0.0, 1.0, 1.0, 3.6)
	
