
extends KinematicBody2D

onready var sprite = get_node("Sprite")

var gravity = 10.0
var speed = Vector2(0,0)
var direction = 1
var walking = false
var can_jump = true

var WALK_SPEED = 3.0
var JUMP_INITIAL_SPEED = 5.0

func _fixed_process(delta):
	if (abs(speed.x) < WALK_SPEED and walking):
		speed.x = direction * smoothstep(speed.x*delta, 0, WALK_SPEED)
		walking = false
	else:
		speed.x = direction * smoothstep(speed.x*delta, WALK_SPEED, 0)

	var motion = move(speed)

	if (is_colliding()):
		speed.y = 0
		var n = get_collision_normal()
		motion = n.slide(motion)
		speed = n.slide(speed)
		move(motion)
		can_jump = true
	else:
		speed.y += gravity * delta
	move(speed)

func _ready():
	set_fixed_process(true)

func walk(dir):
	walking = true
	if (dir == 3):
		direction = -1
		sprite.set_flip_h(true)
	elif (dir == 1):
		direction = 1
		sprite.set_flip_h(false)
	else:
		walking = false

func jump(act):
	if (can_jump):
		speed.y -= JUMP_INITIAL_SPEED
		can_jump = false

func smoothstep(i, a, b):
	var v = i * i * (3 - 2 * i)
	return a * v + b * (1 - v)
