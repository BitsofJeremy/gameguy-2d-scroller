extends KinematicBody2D

const FLOOR = Vector2(0, -1)
var motion = Vector2()
const GRAVITY = 10
# Go to the right first
var DIRECTION = 1
export(int) var SPEED = 60
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
		print("touching a wall")
		DIRECTION = DIRECTION * -1
		# move raycast to proper side
		$floorDetect.position.x *= -1
		
	# Detect ledge and change direction
	if $floorDetect.is_colliding() == false:
		DIRECTION = DIRECTION * -1
		# move raycast to proper side
		$floorDetect.position.x *= -1

func _on_Timer_timeout():
	queue_free()
