extends Node2D

export(int) var health = 100

var money = 100

signal player_death

func receive_damage(damage):
  health -= damage
  printt("damage taken", damage, " health=", health)

  if health <= 0:
    emit_signal("player_death")
