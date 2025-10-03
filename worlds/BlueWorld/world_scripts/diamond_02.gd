extends Node2D

# Set the diamond to be worth 5 points
export var value = 5

func _on_bg_diamond_body_entered(body):
	if get_parent() != null:
		if body.get_name() == 'player':
			print("player collected a BIG diamond")
			# Oddly need to get the parent of the parent if you nest the diamonds
			global_var.score += value
			get_parent().get_parent().score += value			
			queue_free()