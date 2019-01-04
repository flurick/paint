extends Node


func grp(group_name, limit_to_one=true):
	var nodes = get_tree().get_nodes_in_group(group_name)
	if nodes:
		if limit_to_one:
			return get_tree().get_nodes_in_group(group_name)[0]
		else:
			return  get_tree().get_nodes_in_group(group_name)
	else:
		return null

func grp_clear(grp):
	get_tree().call_group(grp, "remove_from_group", grp )
#	for node in get_tree().get_nodes_in_group(group_name):
#		node.remove_from_group(group_name)


var layer = {}
func _ready():
	for i in range(1, 21):
		var layer_name = ProjectSettings.get_setting( str("layer_names/2d_physics/layer_", i) )
		layer[layer_name] = i-1
	get_tree().get_root().set_physics_object_picking(true)

#func _input(event):
#	print(event.as_text())
