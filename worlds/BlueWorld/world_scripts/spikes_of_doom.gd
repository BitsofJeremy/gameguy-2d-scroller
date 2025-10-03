extends Area2D

func _on_spikes_of_doom_body_entered(body):
	var bodies = get_overlapping_bodies()
	for body in bodies:
		if body.name == 'player':
			print("player dead!")
			# Change to REKT screen
			get_tree().change_scene("REKT.tscn")
