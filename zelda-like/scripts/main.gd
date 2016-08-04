
extends Node

const GamePlay = preload("res://zelda-like/resources/states/gameplay.tscn")

var current_state

func _ready():
    current_state = GamePlay.instance()
    self.add_child(current_state)
