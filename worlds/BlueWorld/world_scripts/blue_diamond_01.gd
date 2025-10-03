extends Sprite

func _process(delta):
	pass


func _on_Area2D_body_entered(body):
	if get_parent() != null:
		if body.get_name() == 'player':
			print("player collected")
			# Oddly need to get the parent of the parent if you nest the diamonds
			get_parent().get_parent().score += value
			queue_free()