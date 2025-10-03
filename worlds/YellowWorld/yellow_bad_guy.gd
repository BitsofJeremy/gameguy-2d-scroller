extends KinematicBody2D

const UP = Vector2(0, -1)
const GRAVITY = 10
#const ACCELERATON = 50
#const MAX_SPEED = 300
const JUMP_HEIGHT = -450

var motion = Vector2()

func _physics_process(delta):
	motion.y += GRAVITY

	if is_on_floor():
		motion.y = JUMP_HEIGHT

	motion = move_and_slide(motion, UP)
	pass