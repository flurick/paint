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

func grp_clear(group_name):
	pass
	#fixme: node is a string?
#	for node in get_tree().get_nodes_in_group(group_name):
#		name.remove_from_group(group_name)


var layer = {}
func _ready():
	for i in range(1, 21):
		var layer_name = ProjectSettings.get_setting( str("layer_names/2d_physics/layer_", i) )
		layer[layer_name] = i-1

#func _input(event):
#	print(event.as_text())
