extends Area2D

# Set the diamond to be worth 1 points
export var value = 1

func _on_yellow_diamond_01_body_shape_entered(body_id, body, body_shape, area_shape):
	if get_parent() != null:
		if body.get_name() == 'player':
			print("player collected")
			# Oddly need to get the parent of the parent if you nest the diamonds
			global_var.score += value
			get_parent().get_parent().score += value
			queue_free()