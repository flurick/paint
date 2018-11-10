extends Panel

var current_target

func _ready():
	hide()

#func _process(delta):
#	if current_target:
#		open(current_target)

func _on_Tree_cell_selected():

	var selectedthing = global.grp("tree").get_selected().get_metadata(0)
	open(selectedthing)


func refresh():
	open(current_target)

func open_form_canvas(target):
	#TODO: mark target in tree when selected from canvas
#	global.grp("tree").select(0) #not implemented in stable 3.0.6
#	global.grp("tree").deselect()
	open(target)


func open(target):
	show()
	current_target = target
#	target.connect("rect_changed",self,"refresh") #fails. and is also never disconnected

	match target.get_class():

		"ColorRect":
			for prop in get_children():
				match prop.name:
					"name": prop.text = target.name
					"color": prop.color = target.color
					"color2": prop.set_color(target.color)
					"rect":
						prop.set_rect(target.rect)# Rect2(target.rect_position.x, target.rect_position.y, target.rect_size.x, target.rect_size.y) )
					"rotation":
						prop.value = target.rect_rotation
#				prop.set_value(selectething.get(prop.name))


func target():
	return current_target
#	if global.grp("tree"):
#		if global.grp("tree").get_selected():
#			return global.grp("tree").get_selected().get_metadata(0)
#	return null


func _on_color_color_edited(color):
	if current_target:
		current_target.set_color(color)



func _on_free_pressed():
	if current_target:
		current_target.queue_free()

func _on_duplicate_pressed():
	if current_target:
		var clone = current_target.duplicate()

		if clone is Control:
			clone.rect_position += Vector2(10,10)
		else:
			clone.postition += Vector2(10,10)

		global.grp("canvas").add_child(clone)
		open(clone)


func _on_add_pressed():
	global.grp("canvas").add_child( load("res://Shape.tscn").instance() )



func _on_name_text_changed(new_text):
	if current_target:
		current_target.name = new_text


func _on_rotation_value_changed(value):
	if current_target:
		current_target.rect_rotation = value


func _on_move_up_pressed():
	if current_target:
		global.grp("canvas").move_child(current_target, global.grp("canvas").get_child_count() )


func _on_move_down_pressed():
	if current_target:
		global.grp("canvas").move_child(current_target, 0)


func _on_randomize_pressed():
	if current_target:
		current_target.set_color( Color(randf(), randf(), randf()) )


func _on_rect_changed_rect(value):
	if current_target:
		current_target.set_rect(value)


func _on_randomize2_pressed():
	hide()
