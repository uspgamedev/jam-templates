extends KinematicBody2D

const BulletScene = preload("res://tower-defense/model/turrets/normal-turret-bullet.tscn")

const Enemy = preload("res://tower-defense/model/enemy_ia.gd")

const speed = 15
const init_pos = 100

var damage
var target
var turret


static func create(turret, target, damage):
  var bullet = BulletScene.instance()
  printt("create bullet ", bullet)

  bullet.damage = damage
  bullet.target = target
  bullet.turret = turret
  
  bullet.set_global_pos(turret.get_node("BulletSpot").get_global_pos())

  return bullet

func _ready():
  set_fixed_process(true)

func _fixed_process(delta):
  var direction = (target.get_pos() - get_pos()) * speed * delta
  #printt("#shot", self, " direction=", direction)

  move(direction)

func _on_bullet_body_enter( body ):
  printt("body=", body)
  body.damage(damage)
  queue_free()