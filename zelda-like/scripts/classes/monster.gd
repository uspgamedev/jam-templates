
extends "res://zelda-like/scripts/classes/body.gd"

const BodyClass = preload("res://zelda-like/scripts/classes/body.gd")
const STAGGER = 64

export var maxHP = 32
export var attack = 8

var damage = 0
var immunity = false

func _ready():
    print("shapes: ",get_shape_count())
    self.set_body_type("monster")

func start_invincibility():
    var timer = get_node("invincibility")
    timer.start()
    immunity = true

func _on_invincibility_timeout():
    immunity = false

func _take_dmg(collider, normal, delta):
    var dist = normal.length()
    self.speed += normal * (ACC*ACC) * STAGGER * delta * 1/(dist*dist)
    self.damage += collider.attack
    start_invincibility()

func _check_collision(motion, collider, normal, delta):
    if (not self.immunity) and \
        collider extends BodyClass and collider.get_body_type() == "monster" and \
        self.get_collision_mask() & collider.get_layer_mask() != 0:
        _take_dmg(collider, normal, delta)
    else:
        _slide(motion, normal)
