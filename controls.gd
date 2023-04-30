extends Node
class_name Controls

var look_pitch := 0.0
var look_yaw := 180.0

func get_just_clapped() -> bool:
	return Input.is_action_just_pressed('clap')
	
func get_stopped_clapping() -> bool:
	return Input.is_action_just_released('clap')

func get_clap_strength() -> float:
	return 0.25 * (
		Input.get_action_strength('clap_1') +
		Input.get_action_strength('clap_2') +
		Input.get_action_strength('clap_3') +
		Input.get_action_strength('clap_4')
	)
	
func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _input(event):
	if event.is_action_pressed("ui_cancel"):
		if Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
			Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)

	elif event is InputEventMouseButton:
		if Input.get_mouse_mode() == Input.MOUSE_MODE_VISIBLE:
			Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	elif event is InputEventMouseMotion:
		var dx = event.relative.x * 0.1 * -1
		var dy = event.relative.y * 0.1 * -1
		look_pitch = clamp(look_pitch + dy, -70, 70)
		look_yaw = wrapf(look_yaw + dx, 0, 360)
