extends Area2D

# Set the diamond to be worth 5 points
export var value = 5

func _on_green_diamond_02_body_entered(body):
	if get_parent() != null:
		if body.get_name() == 'player':
			print("player collected green BIG diamond")
			# Oddly need to get the parent of the parent if you nest the diamonds
			#global_var.score += value
			get_parent().get_parent().score += value
			queue_free()