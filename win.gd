extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	await Fade.fade_in(7.0).finished
	await Fade.fade_out(5.0).finished
	get_tree().quit()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
