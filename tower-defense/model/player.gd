extends Node2D

export(int) var health = 100

var money = 100

signal player_death

onready var lifebar = get_node("LifeBar")
onready var money_label = get_node("Money")

func _ready():
  lifebar.set_value(health)
  money_label.set_text("$ %d" % money)

func receive_damage(damage):
  health -= damage
  printt("damage taken", damage, " health=", health)

  if health <= 0:
    emit_signal("player_death")

  lifebar.set_value(health)
