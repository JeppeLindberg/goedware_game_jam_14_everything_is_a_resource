extends MarginContainer

@export var score_prefab: PackedScene
@onready var v_box_container = get_node('VBoxContainer')
@onready var title = get_node('VBoxContainer/title')

func add_score(new_score):
	var score_nodes = v_box_container.get_children();
	score_nodes.erase(title)
	var new_node = null
	for i in len(score_nodes):
		var score = ''
		for symbol in score_nodes[i].text:
			if symbol in ['0','1','2','3','4','5','6','7','8','9']:
				score += symbol
		if (int(score) <= new_score) and (new_score != -1):
			new_node = score_prefab.instantiate()
			v_box_container.add_child(new_node)
			new_node.text = 'YOU: ' + str(new_score)
			new_node.self_modulate = Color.AQUAMARINE
			new_score = -1

		new_node = score_prefab.instantiate()
		v_box_container.add_child(new_node)
		new_node.text = score_nodes[i].text
		new_node.self_modulate = Color.WHITE
	
	for node in score_nodes:
		node.queue_free()
	score_nodes = v_box_container.get_children();
	score_nodes.erase(title)
	score_nodes.back().queue_free()
	


	
