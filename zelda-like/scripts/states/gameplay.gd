
extends Node2D

var _hero

func _ready():
    var input = get_node("/root/input")
    self._hero = get_node("map/bodies/hero")
    _start_camera()
    input.connect("hold_direction", self._hero, "_move_to")
    input.connect("press_quit", self, "_quit")
    set_process(true)

func _start_camera():
    var cam = Camera2D.new()
    self._hero.add_child(cam)
    cam.make_current()

func _process(delta):
    if self._hero.damage >= self._hero.maxHP:
        get_tree().quit()

func _quit():
    get_tree().quit()

func get_hero():
    return self._hero
