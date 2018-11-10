extends ColorRect


func _ready():
	randomize()
	color = Color(randf(), randf(), randf(), 0.62)
	update()


func _input(event):
	if event is InputEventMouseMotion:
		if is_in_group("held"):
			rect_position += event.relative 
		if is_in_group("resize"):
			$Polygon2D.scale += event.relative * 0.01
	
	if event is InputEventMouseButton:
		if not event.pressed:
			if is_in_group("held"):  remove_from_group("held")
			if is_in_group("resize"):  remove_from_group("resize")


func _on_move_gui_input(event):
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT:
			if event.pressed:
				global.grp("props").open_form_canvas(self)
				add_to_group("held")
#				global.grp_clear("marked")
#				add_to_group("marked")
				global.grp("props").open(self)


func _on_resize_gui_input(event):
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT:
			if event.pressed:
				global.grp("props").open_form_canvas(self)
				add_to_group("resize")
				global.grp_clear("resize")
				add_to_group("resize")


func update():
#	if is_in_group("marked"):
	draw_line( rect_position, rect_size, ColorN("white"))
	draw_line( rect_position+Vector2(1,1), rect_size+Vector2(1,1), ColorN("black"))


