
extends Area2D

export(Script) var eventScript

var EVENT

func _ready():
    EVENT = eventScript.new(self)

func _on_area_event_body_enter(body):
    EVENT.run(body)
