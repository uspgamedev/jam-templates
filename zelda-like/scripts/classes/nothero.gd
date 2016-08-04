
extends "res://zelda-like/scripts/classes/monster.gd"

export(Script) var behaviourScript

var BEHAVIOUR

func _ready():
    self.animation.queue("idle")
    BEHAVIOUR = behaviourScript.new(self, true)
    set_process(true)

func _process(delta):
    BEHAVIOUR.update(delta)
