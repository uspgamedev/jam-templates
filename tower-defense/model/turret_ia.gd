extends Area2D

export var health = 10
export var damage = 10
export var shoot_speed = 1.0
export var turn_speed = 1.0
export var name = "default turret"

onready var vision = get_node("Vision").get_shape()

var targets = []

func _ready():
  set_fixed_process(true)
  connect("body_enter", self, "target_enemy")
  connect("body_exit", self, "untarget_enemy")
  printt("shapes=", get_shape_count())

func target_enemy(enemy):
  printt("Vai muleque")
  targets.push_back(enemy)
  printt("targets=", targets)

func untarget_enemy(enemy):
  printt("Nao Vai muleque")
  targets.remove(targets.find(enemy))


func _fixed_process(delta):
  if targets.size() == 0:
    return

  #look_at(targets[0])
