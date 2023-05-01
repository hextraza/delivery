extends Node2D

func _ready():
	await Fade.fade_in(7.0).finished
	await Fade.fade_out(5.0).finished
	get_tree().change_scene_to_file("res://world.tscn")

func _process(delta):
	pass
