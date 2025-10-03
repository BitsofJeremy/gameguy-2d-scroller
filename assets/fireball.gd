extends Area2D

const SPEED = 650
var direction = 1
var motion = Vector2()

func _ready():
	pass

func set_fireball_directio(dir):
	direction = dir
	if dir == -1:
		$AnimatedSprite.flip_h == true

func _physics_process(delta):
	motion.x = SPEED * delta * direction
	translate(motion) 
	$AnimatedSprite.play('default')

func _on_VisibilityNotifier2D_screen_exited():
	queue_free()

func _on_fireball_body_entered(body):
	#print(body)
	var bodies = get_overlapping_bodies()
	for body in bodies:
		# enemy detect
		if body.name != 'TileMap':
			#print("hit:  " + body.name)
			body.dead()
			queue_free()
		else:
			queue_free()
