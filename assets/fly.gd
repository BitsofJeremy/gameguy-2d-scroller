extends KinematicBody2D

const FLOOR = Vector2(0, -1)
var motion = Vector2()
const GRAVITY = 0
# Go to the left first
var DIRECTION = -1
export(int) var SPEED = 250
var IS_DEAD = false
export(int) var HP = 2


func dead():
	HP -= 1
	if HP <= 0:
		IS_DEAD = true
		motion = Vector2(0,0)
		$AnimatedSprite.play('dead')
		$CollisionShape2D.disabled = true
		$Timer.start()


func _physics_process(delta):
	if IS_DEAD == false:
		motion.y += GRAVITY
		motion.x = SPEED * DIRECTION
		
		# Change the animation direction
		if DIRECTION == 1:
			$AnimatedSprite.flip_h = true
		else:
			$AnimatedSprite.flip_h = false
		
		$AnimatedSprite.play('default')
			
		motion = move_and_slide(motion, FLOOR)
		if get_slide_count() > 0:
			for i in range(get_slide_count()):
				if "player" in get_slide_collision(i).collider.name:
					get_slide_collision(i).collider.dead()

	# Detect wall and change direction
	if is_on_wall():
		DIRECTION = DIRECTION * -1

func _on_Timer_timeout():
	queue_free()


func _on_VisibilityNotifier2D_viewport_exited(viewport):
	DIRECTION = DIRECTION * -1
