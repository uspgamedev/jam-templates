
extends Object

var trigger = false
var active = false
var node

func _init(actor, enable):
    active = enable or false
    node = actor

func update(delta):
    pass
