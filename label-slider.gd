extends Label

var pressed = false
var value = 1
var label = ""
export (float) var ratio = 1

signal changed(value)

func _gui_input(event):
	if event is InputEventMouseButton\
	or event is InputEventScreenTouch:
		if event.pressed:
			pressed = true

func _input(event):
	if event is InputEventMouseButton\
	or event is InputEventScreenTouch:
		if not event.pressed:
			pressed = false
	
	if pressed \
	and event is InputEventMouseMotion:
		value += event.relative.x*ratio
		value -= event.relative.y*ratio
		
		text = str(label, value)
		emit_signal("changed", value)
