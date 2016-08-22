
extends Node

onready var map = preload("res://platform/resources/map.tscn")
onready var player = get_node("Player")

func _ready():
	var input = get_node("/root/input")
	input.connect("hold_direction", player, "walk")
	input.connect("press_quit", self, "_quit")
	input.connect("press_action", player, "jump")
	set_process(true)

func _start_camera():
	var cam = Camera2D.new()
	player.add_child(cam)
	cam.make_current()

func _process(delta):
	pass

func _quit():
	get_tree().quit()

