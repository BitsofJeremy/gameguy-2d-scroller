extends KinematicBody2D

const UP = Vector2(0, -1)
const GRAVITY = 20
const ACCELERATON = 60
const MAX_SPEED = 550
const JUMP_HEIGHT = -550
const FIREBALL =  preload("res://assets/fireball.tscn")
var is_attacking = false
var points = 0

var motion = Vector2()

var IS_DEAD = false

func dead():
	IS_DEAD = true
	motion = Vector2(0,0)
	$sprite.play('dead')
	$CollisionShape2D.disabled == true
	$Timer.start()
	

func _physics_process(delta):
	if IS_DEAD == false:
		motion.y += GRAVITY
		var friction = false
		if Input.is_action_pressed("ui_right") or Input.is_action_pressed("move_right"):
			if is_attacking == false:
				motion.x = min(motion.x + ACCELERATON, MAX_SPEED)
				$sprite.flip_h = false
				$sprite.play('walk')
				if sign($Position2D.position.x) == -1:
					$Position2D.position *= -1
				
		elif Input.is_action_pressed("ui_left") or Input.is_action_pressed("move_left"):
			if is_attacking == false:
				motion.x -= ACCELERATON
				motion.x = max(motion.x - ACCELERATON, -MAX_SPEED)
				$sprite.flip_h = true
				$sprite.play('walk')
				if sign($Position2D.position.x) == 1:
					$Position2D.position *= -1
		else:
			if is_attacking == false:
				$sprite.play('idle')
				friction = true
				motion.x = lerp(motion.x, 0, 0.2)
	
		if Input.is_action_just_pressed("ui_focus_next") or Input.is_action_pressed("shoot") && is_attacking == false:
			is_attacking = true
			# Set attack animation to wave
			$sprite.play('wave')
			var fireball = FIREBALL.instance()
			if sign($Position2D.position.x) == 1:
				fireball.set_fireball_directio(1)
			else:
				fireball.set_fireball_directio(-1)
			get_parent().add_child(fireball)
			fireball.position = $Position2D.global_position
	
		if is_on_floor():
			if is_attacking == false:
				if Input.is_action_just_pressed("ui_up") or Input.is_action_pressed("jump"):
					motion.y = JUMP_HEIGHT
				if friction == true:
					motion.x = lerp(motion.x, 0, 0.2)
		else:
			if is_attacking == false:
				$sprite.play('jump')
				if friction == true:
					is_attacking == false
					motion.x = lerp(motion.x, 0, 0.05)
			
		motion = move_and_slide(motion, UP)
		pass
		
		if get_slide_count() > 0:
			for i in range(get_slide_count()):
				if "madBlock" in get_slide_collision(i).collider.name:
					dead()
				elif "slime" in get_slide_collision(i).collider.name:
					dead()
				elif "fly" in get_slide_collision(i).collider.name:
					dead()
				elif "snail" in get_slide_collision(i).collider.name:
					dead()

func _on_sprite_animation_finished():
	is_attacking = false
	
func _on_Timer_timeout():
	get_tree().change_scene("REKT.tscn")
