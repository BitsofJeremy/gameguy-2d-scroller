extends Area2D

# Set the diamond to be worth 5 points
export var value = 5

func _on_orange_diamond_02_body_shape_entered(body_id, body, body_shape, area_shape):
	if get_parent() != null:
		if body.get_name() == 'player':
			print("player collected")
			# Oddly need to get the parent of the parent if you nest the diamonds
			global_var.score += value
			get_parent().get_parent().score += value
			queue_free()
