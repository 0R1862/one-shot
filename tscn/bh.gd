extends Area2D


func _on_body_entered(body):
	if body.is_in_group("p2"):
		get_tree().change_scene_to_file("res://tscn/main_menu.tscn")
	else:
		queue_free()
