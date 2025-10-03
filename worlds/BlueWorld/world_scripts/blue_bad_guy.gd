extends Area2D

func _on_blue_bad_guy_body_entered(body):
	var bodies = get_overlapping_bodies()
	for body in bodies:
		if body.name == 'player':
			print("player touched me!")
			get_tree().change_scene("REKT.tscn")
