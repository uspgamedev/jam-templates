
extends "res://components/controller/default_controller.gd"

const Lame = preload("res://tower-defense/model/enemy/lame-enemy.tscn")

func event_create_lame():
  var lame = Lame.instance()
  lame.set_board(get_parent().get_board())
  get_parent().get_board().get_node("enemies").add_child(lame)

  lame.connect("arrive", get_parent() , "receive_damage")
  lame.connect("enemy_died", get_parent() , "receive_money")

func event_cancel():
  if get_parent().get_selected_turret() == null:
    printt("exiting")
    .event_cancel()
  else:
    get_parent().unselect_turret()
    return

func event_select():
  print("place turret")
  get_parent().place_turret()