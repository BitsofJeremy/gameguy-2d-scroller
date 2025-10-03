extends Node
var score = global_var.score
func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	pass

func _process(delta):
	$HUD.update_score(score)
