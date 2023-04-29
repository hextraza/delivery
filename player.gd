extends Node3D

@onready var controls := $Controls as Controls
@onready var camera := $Camera as Camera3D
@onready var arms := $Arms as Node3D
@onready var hands := $Arms/Hands as Node3D
@onready var hands_skeleton := $hands/metarig/Skeleton3D as Skeleton3D
@onready var anim_player := $hands/AnimationPlayer as AnimationPlayer
@onready var hand_height_path := $hands/intensity_height as Path3D

func _process(delta):
	anim_player.current_animation = "clap"
	var intensity := controls.get_clap_strength()
	
	hands_skeleton.position = hand_height_path.curve.samplef(intensity)
	anim_player.speed_scale = intensity * 4
