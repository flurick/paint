extends StaticBody2D

#func _ready():
#	var shape = ConvexPolygonShape2D.new()
#	shape.points = $Polygon2D.polygon
#	$CollisionShape2D.shape = shape


func set_color(arg):
	$Polygon2D.color = arg


func _input(event):

	if is_in_group("hover"):
		
		if event is InputEventMouseButton:
			if event.button_index == BUTTON_LEFT:
				if event.pressed:
					add_to_group("held")
					add_to_group("marked")
					if global.grp("props"):
						global.grp("props").open_form_canvas(self)
						global.grp("props").open(self)


	if event is InputEventMouseMotion:
		if is_in_group("held"):
			position += event.relative
		if is_in_group("resize"):
			scale += event.relative

	if event is InputEventMouseButton:
		if not event.pressed:
			if is_in_group("held"):  remove_from_group("held")
			if is_in_group("resize"):  remove_from_group("resize")


func _on_resize_gui_input(event):
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT:
			if event.pressed:
				global.grp("props").open_form_canvas(self)
				add_to_group("resize")
				global.grp_clear("resize")
				add_to_group("resize")




func _on_Polygon_mouse_entered():
	print("hovering: ", name)
	add_to_group("hover")


func _on_Polygon_mouse_exited():
	print("hovering no more: ", name)
	if is_in_group("hover"):
		remove_from_group("hover")
