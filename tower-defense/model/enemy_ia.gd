extends KinematicBody2D

export var health = 10
export var core_damage = 10
export var speed = 1.0
export var name = "default monster"

var next_point = null
var finish = Vector2()
var nav_board = null
var board = null
var board_half_diagonal = 32

signal arrive

func set_board(board):
  set_pos(board.get_node("init").get_pos())
  finish = board.get_node("finish").get_global_pos()
  nav_board = board.get_parent()
  self.board = board
  #board_half_diagonal = floor(sqrt(pow(board.get_cell_size().x, 2) + pow(board.get_cell_size().y, 2)) / 2) + 1
  board_half_diagonal = 1

func _ready():
  set_fixed_process(true)

func get_direction(origin, destiny):
  var direction = (destiny - origin).normalized()
  printt("orig=", origin, "dest=", destiny, "direc=", direction)

  if abs(direction.y) == abs(direction.x):
    return Vector2(1,0)

  if abs(direction.y) > abs(direction.x):
    if direction.y > 0:
      return Vector2(0, 1)
    else:
      return Vector2(0, -1)

  if direction.x > 0:
    return Vector2(1, 0)
  return Vector2(-1, 0)

var points = []

func get_next_point():
  points = nav_board.get_simple_path(get_global_pos(), finish, false)
  
  var index = 0
  for p in points:
    if index > 0:
      p = board.world_to_map(p)
      p = board.map_to_world(p) + Vector2(board.get_cell_size().x / 2,  board.get_cell_size().y / 2)
      if p.distance_to(get_global_pos()) > board_half_diagonal:
        return p
    index += 1


func _fixed_process(delta):
  if finish.distance_to(get_global_pos()) < board_half_diagonal:
    emit_signal("arrive")
    queue_free()
    return

  if next_point == null || next_point.distance_to(get_global_pos()) < board_half_diagonal:
    next_point = get_next_point()
    printt("next point", next_point)

  var direction = get_direction(get_global_pos(), next_point)
  move(direction * speed)
  update()

func _draw():
  # if there are points to draw
  if points.size() < 1:
    return
  for p in points:
    draw_circle(p - get_global_pos(), 8, Color(1, 0, 0))
  draw_circle(next_point - get_global_pos(), 8, Color(1, 0, 1))
