extends Area2D

# Set the diamond to be worth 1 points
export var value = 1

func _on_green_diamond_01_body_entered(body):
	if get_parent() != null:
		if body.get_name() == 'player':
			print("player collected")
			# Oddly need to get the parent of the parent if you nest the diamonds
			#global_var.score += value
			get_parent().get_parent().score += value
			queue_free()
