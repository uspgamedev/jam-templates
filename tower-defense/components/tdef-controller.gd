
extends "res://components/controller/default_controller.gd"

const Lame = preload("res://tower-defense/model/enemy/lame-enemy.tscn")

func event_create_lame():
  var lame = Lame.instance()
  lame.set_board(get_node("../BoardNav/BoardMap"))
  get_node("../BoardNav/BoardMap/enemies").add_child(lame)

  lame.connect("arrive", get_node("../Player") , "receive_damage")
