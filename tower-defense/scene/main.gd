extends Node2D

onready var player = get_node("Player")
onready var board = get_node("BoardNav/BoardMap")

func _on_turret_selected():
	set_fixed_process(true)

static func center_tile_point(board, point):
  point = board.world_to_map(point)
  point = board.map_to_world(point) + Vector2(board.get_cell_size().x / 2,  board.get_cell_size().y / 2)
  return point

func _fixed_process(delta):
	var selected_turret = get_node("Player").get_selected_turret()
	if selected_turret == null:
		set_fixed_process(false)
		return
	
	selected_turret.set_pos(center_tile_point(board, get_viewport().get_mouse_pos()))
	selected_turret.show()

func _on_player_place_turret( turret ):
	printt("turret=", turret, " pos=", turret.get_pos())
	board.get_node("turrets").add_child(turret)
	printt("turrets=", board.get_node("turrets").get_children())
	turret.show()
	player.unselect_turret()
