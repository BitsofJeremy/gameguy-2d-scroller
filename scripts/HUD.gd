extends CanvasLayer

var score = global_var.score

func _ready():
	update_score(score)

func update_score(score):
    $score.text = "SCORE: " + str(score)

    