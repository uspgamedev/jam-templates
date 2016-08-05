
extends KinematicBody2D

const DIR = preload("res://zelda-like/scripts/utility/directions.gd")

const ACC = 32
const DEACC = 0.75
const SPEEDLIMIT = ACC * 5
const EPSILON = 1

var _ref_dirs = DIR.new()

export(int, "up", "right", "down", "left") var direction
export(bool) var strife

var speed = Vector2()
var animation
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
    if self.speed.length_squared() > EPSILON:
        var anim = _get_animdirection() + "moving"
        if self.animation.get_current_animation() != anim:
            self.animation.play(anim)
    elif self.speed.length_squared() <= EPSILON:
        var anim = _get_animdirection() + "idle"
        if self.animation.get_current_animation() != anim:
            self.animation.play(anim)

func _fixed_process(delta):
    self._apply_speed(delta)
    self._apply_speedlimit(delta)

func _move_to(dir):
    if not strife: face(dir)
    self.speed += _ref_dirs.get_dir(dir) * ACC

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

func set_body_type(type):
    if type == "monster":
        self._body_type = 1
    elif type == "npc":
        self._body_type = 2
    else:
        self._body_type = 0

func get_body_type():
    if self._body_type == 1:
        return "monster"
    elif self._body_type == 2:
        return "npc"
    else:
        return "body"

func lock_face():
    self.strife = true

func unlock_face():
    self.strife = false

func face(dir):
    if dir == DIR.UP:
        self.direction = DIR.UP
    elif dir == DIR.RIGHT:
        self.direction = DIR.RIGHT
    elif dir == DIR.DOWN:
        self.direction = DIR.DOWN
    elif dir == DIR.LEFT:
        self.direction = DIR.LEFT
    elif dir == DIR.UP_RIGHT:
        self.direction = DIR.RIGHT
    elif dir == DIR.DOWN_RIGHT:
        self.direction = DIR.RIGHT
    elif dir == DIR.DOWN_LEFT:
        self.direction = DIR.LEFT
    elif dir == DIR.UP_LEFT:
        self.direction = DIR.LEFT

func _get_animdirection():
    if self.direction == DIR.UP:
        return "up_"
    elif self.direction == DIR.RIGHT:
        return "right_"
    elif self.direction == DIR.DOWN:
        return "down_"
    elif self.direction == DIR.LEFT:
        return "left_"
