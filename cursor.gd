extends Polygon2D

func _process(delta):
	velocity *= 0.5
	$"../tail".points[0] = position
	$"../tail".points[1] = $"../hand".position

var velocity = Vector2(0,0)

#func _draw():
#
#	set_as_toplevel(true)
#	draw_line( \
#		get_node("../hand").global_position, \
#		get_parent().global_position, \
#		Color(0.5, 0.8, 0.5), 3 )
		
#	draw_line( \
#		get_node("../hand").get_global_transform().affine_inverse() * global_position, \
#		get_global_transform().affine_inverse() * get_parent().global_position, \
#		Color(0.5, 0.5, 0.5), 3 )

#func _input(event):	
##	if event is InputEventMouseMotion:
##		position += event.position
#	update()