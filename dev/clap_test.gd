extends Control

@onready var controls := $Controls as Controls

func _process(_delta: float) -> void:
	$ProgressBar.value = controls.get_clap_strength() * 25.0
