extends Node
class_name Controls

func get_clap_strength() -> float:
	return (
		Input.get_action_strength('clap_1') +
		Input.get_action_strength('clap_2') +
		Input.get_action_strength('clap_3') +
		Input.get_action_strength('clap_4')
	)

