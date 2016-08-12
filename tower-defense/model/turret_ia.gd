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

var targets = []
var on_target = false

func _ready():
  set_fixed_process(true)
  connect("body_enter", self, "target_enemy")
  connect("body_exit", self, "untarget_enemy")
  turn_timer.set_wait_time(turn_speed)
  turn_timer.start()
  shoot_timer.set_wait_time(shoot_speed)
  shoot_timer.start()
  printt("shapes=", get_shape_count())

func target_enemy(enemy):
  if not enemy extends Enemy:
    return
  printt("Vai muleque")
  targets.push_back(enemy)
  printt("targets=", targets[0])

func untarget_enemy(enemy):
  if not enemy extends Enemy:
     return
  printt("Nao Vai muleque")
  targets.remove(targets.find(enemy))

func _on_turn_timeout():
  if targets.size() == 0:
    return
  var target_pos = targets[0].get_pos()
  var target_angle = get_angle_to(target_pos)

  if target_angle > 0.1:
    set_rot(get_rot() + TURN_STEP)
  elif target_angle < -0.1:
    set_rot(get_rot() - TURN_STEP)
  else:
    on_target = true


func _on_shoot_timeout():
  if targets.size() == 0:
    return
  if not on_target:
    return
  if bullets.get_child_count() == 1:
    return

  on_target = false  

  var bullet = Bullet.create(self, targets[0], damage)
  bullets.add_child(bullet)
  printt("shoot")
