extends Node
class_name Controls

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

