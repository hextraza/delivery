extends Node3D

@onready var controls := $Controls as Controls
@onready var camera := $Camera as Camera3D
@onready var arms := $Arms as Node3D
@onready var hands := $Arms/Hands as Node3D

@onready var hand_one := hands.get_child(0) as Node3D
@onready var hand_two := hands.get_child(1) as Node3D

@export var clap_freq_scale := 4.0
@export var clap_curve := Curve.new()

var _clap_delta := 0.0
var _clap_angle := 0.0

func _physics_process(delta: float) -> void:
	var clap := controls.get_clap_strength()
	var angle := (-0.25*PI) if is_zero_approx(clap) else (-0.125*PI)
	_clap_angle = move_toward(_clap_angle, angle, delta)
	_clap_delta += clap * clap_freq_scale * delta
	arms.rotation.x = _clap_angle
	hand_one.position.x = clap_curve.sample(fposmod(_clap_delta, 1))
	hand_two.position.x = -hand_one.position.x
