extends Node2D

onready var player = get_node("Player")
onready var controller = get_node("Controller")
onready var death_controller = get_node("DeathController")

func _ready():
  player.connect("player_death", self, "player_died")
  get_node("DeathAlert").hide()
  controller.enable()
  death_controller.disable()

func player_died():
  printt("player died")
  controller.disable()
  death_controller.enable()
  get_node("DeathAlert").show()
