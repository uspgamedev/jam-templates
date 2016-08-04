
extends "res://zelda-like/scripts/events/event.gd"

func _init(actor).(actor):
    pass

func _action(body):
    if body:
        print(body.get_type(), "has collided with me! Hello.")
    else:
        print("?????? what")
