
extends KinematicBody2D

const DIR = preload("res://zelda-like/scripts/utility/directions.gd")

const ACC = 32
const DEACC = 0.75
const SPEEDLIMIT = ACC * 5
const EPSILON = 1
const ANIM_IDLE = 0
const ANIM_MOVE = 1

var directions = DIR.new()
var speed = Vector2()
var animation
var state = 0
var _body_type
# body types:
#   body    0
#   monster 1
#   npc     2

func _ready():
    self.animation = get_node("sprite/animation")
    set_process(true)
    set_fixed_process(true)

func _process(delta):
    if self.speed.length_squared() > EPSILON and state != ANIM_MOVE:
        #print("moving!")
        self.state = ANIM_MOVE
        self.animation.play("moving")
    elif self.speed.length_squared() <= EPSILON and state != ANIM_IDLE:
        #print("stoping!")
        self.state = ANIM_IDLE
        self.animation.play("idle")

func _fixed_process(delta):
    self._apply_speed(delta)
    self._apply_speedlimit(delta)

func _move_to(dir):
    self.speed += directions.get_dir(dir) * ACC

func _apply_speedlimit(delta):
    self.speed *= DEACC
    if self.speed.length_squared() <= EPSILON*EPSILON:
        self.speed.x = 0
        self.speed.y = 0

func _check_collision(motion, collider, normal, delta):
    _slide(motion, normal)

func _apply_speed(delta):
    var motion = move( self.speed * delta )
    if is_colliding():
        var collider = get_collider()
        var normal = get_collision_normal()
        _check_collision(motion, collider, normal, delta)

func _slide(motion, normal):
    motion = normal.slide(motion)
    self.speed = normal.slide(self.speed)
    move(motion)

func get_body_type():
    if self._body_type == 1:
        return "monster"
    elif self._body_type == 2:
        return "npc"
    else:
        return "body"

func set_body_type(type):
    if type == "monster":
        self._body_type = 1
    elif type == "npc":
        self._body_type = 2
    else:
        self._body_type = 0
