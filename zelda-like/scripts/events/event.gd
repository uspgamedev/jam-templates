
extends Object

var node

func _init(actor):
    node = actor

func _action(params):
    pass

func run(params):
    self._action(params)
    print("ACTION!")
