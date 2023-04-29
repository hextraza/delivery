extends Node3D


func _ready():
	var shift = false
	var children = self.get_children()
	
	for i in range(children.size()):			
		var beak = load("res://beak.tscn").instantiate()
		beak.position = children[i].position
		
		if shift:
			var pos = beak.position
			beak.position.x += 0.5
			
		if i % 27 == 0:
			shift = !shift
			
		add_child(beak)

func _process(delta):
	pass
