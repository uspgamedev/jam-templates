
extends "res://zelda-like/scripts/classes/monster.gd"

const DIR = preload("res://zelda-like/scripts/utility/directions.gd")
const MONSTER = preload("res://zelda-like/scripts/classes/monster.gd")

onready var sprite = get_node("sprite")
onready var hitbox = get_node("hitbox")

func _move_to(dir):
  ._move_to(dir)
  if direction == DIR.UP:
    set_rotd(180)
    sprite.set_rotd(-180)
  elif direction == DIR.DOWN:
    set_rotd(0)
    sprite.set_rotd(0)
  elif direction == DIR.LEFT:
    set_rotd(270)
    sprite.set_rotd(-270)
  elif direction == DIR.RIGHT:
    set_rotd(90)
    sprite.set_rotd(-90)

func _act(act):
  printt("act=", act)
  if act == 0:
    var range_bodies = hitbox.get_overlapping_bodies()
    printt("bodies=", range_bodies)
    for body in range_bodies:
      if body extends MONSTER:
        printt("monster=", body)
        body.take_dmg(body.attack)
