extends KinematicBody2D

const FLOOR = Vector2(0, -1)
var motion = Vector2()
const GRAVITY = 10

# Go to the right first
var DIRECTION = 1
export(int) var SPEED = 160
var IS_DEAD = false
export(int) var HP = 3
export(Vector2) var size = Vector2(1, 1)

func dead():
	HP -= 1
	#print(HP)
	if HP <= 0:
		IS_DEAD = true
		motion = Vector2(0,0)
		$AnimatedSprite.play('dead')
		$CollisionShape2D.disabled = true
		$Timer.start()
		if size > Vector2(1, 1):
			get_parent().get_parent().get_node("ScreenShake").screen_shake(1,10,100)

func _ready():
	scale = size

func _physics_process(delta):
	if IS_DEAD == false:
		motion.y += GRAVITY
		motion.x = SPEED * DIRECTION
		
		# Change the animation direction
		if DIRECTION == 1:
			$AnimatedSprite.flip_h = false
		else:
			$AnimatedSprite.flip_h = true
		
		$AnimatedSprite.play('default')
			
		motion = move_and_slide(motion, FLOOR)
		if get_slide_count() > 0:
			for i in range(get_slide_count()):
				if "player" in get_slide_collision(i).collider.name:
					get_slide_collision(i).collider.dead()

	# Detect wall and change direction
	if is_on_wall():
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
