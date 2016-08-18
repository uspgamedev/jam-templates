extends Area2D

const TURN_STEP = 0.1

const Bullet = preload("res://tower-defense/model/turrets/normal-turret-bullet.gd")

const Enemy = preload("res://tower-defense/model/enemy_ia.gd")

export var damage = 10
export var price = 100
export var shoot_speed = 0.5
export var turn_speed = 0.02
export var name = "default turret"

onready var vision = get_node("Vision").get_shape()
onready var turn_timer = get_node("TurnTimer")
onready var shoot_timer = get_node("ShootTimer")
onready var bullets = get_node("Bullets")
onready var shoot_area = get_node("ShootArea")

var enabled = false

var targets = []

func disable():
  enabled = false

func enable():
  enabled = true

func is_enabled():
  return enabled

func _ready():
  set_fixed_process(true)
  connect("body_enter", self, "target_enemy")
  connect("body_exit", self, "untarget_enemy")
  turn_timer.set_wait_time(turn_speed)
  turn_timer.start()
  shoot_timer.set_wait_time(shoot_speed)
  shoot_timer.start()
  #printt("shapes=", get_shape_count())

func get_price():
  return price

func target_enemy(enemy):
  if not enemy extends Enemy:
    return
  #printt("enemy targeted")
  targets.push_back(enemy)
  #printt("targets=", targets[0])

func untarget_enemy(enemy):
  if not enemy extends Enemy:
     return
  #printt("enemy is gone")
  targets.remove(targets.find(enemy))

func _on_turn_timeout():
  if not is_enabled():
    return
  if targets.size() == 0:
    return
  var target_pos = targets[0].get_pos()
  var target_angle = get_angle_to(target_pos)

  if target_angle > 0.1:
    set_rot(get_rot() + TURN_STEP)
  elif target_angle < -0.1:
    set_rot(get_rot() - TURN_STEP)

func _on_shoot_timeout():
  if not is_enabled():
    return
  if targets.size() == 0:
    return
  if not shoot_area.overlaps_body(targets[0]):
    return
  if bullets.get_child_count() == 1:
    return

  var bullet = Bullet.create(self, targets[0], damage)
  bullets.add_child(bullet)
  #printt("shoot")
