extends Node3D


func _ready():
	for child in self.get_children():
		var beak = load("res://beak.tscn").instantiate()
		beak.global_position = child.global_position
		add_child(beak)

func _process(delta):
	pass
