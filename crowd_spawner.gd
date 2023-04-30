extends Node3D

var beaks = []
var timer = 0.0
var event_triggered = 0

func _ready():
	var shift = false
	var children = self.get_children()
	
	for i in children.size():			
		var beak = load("res://beak.tscn").instantiate()
		beak.global_position = children[i].global_position
		
		if shift:
			var pos = beak.position
			beak.position.x += 0.5
			
		if i % 27 == 0:
			shift = !shift
		
		add_child(beak)
		beaks.append(beak)

func _process(delta):
	timer += delta
	
	if timer > 0.1 && timer <= 10.0 && event_triggered == 0:
		event_triggered = 1
		
		for beak in beaks:
			beak.toggle_clap()
		
	if timer > 10.0 && event_triggered < 2:
		event_triggered = 2
		
		for beak in beaks:
			beak.toggle_clap()
