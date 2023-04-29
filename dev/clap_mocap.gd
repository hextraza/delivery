extends Node3D

func clap():
	var anim_player := $SceneLoader/AnimationPlayer as AnimationPlayer
	if anim_player.is_playing():
		anim_player.seek(0.0)
	anim_player.play('clap', -1, 2.0)

func _physics_process(delta: float) -> void:
	if $Controls.get_just_clapped():
		clap()
