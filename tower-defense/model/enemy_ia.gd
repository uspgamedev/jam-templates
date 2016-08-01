extends KinematicBody2D

export var health = 10
export var core_damage = 10
export var speed = 1.0
export var name = "default monster"

var points = []
var finish = Vector2()
var nav_board = null
var board = null

signal arrive

func set_board(board):
  set_pos(board.get_node("init").get_pos())
  finish = board.get_node("finish").get_global_pos()
  nav_board = board.get_parent()
  self.board = board


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

func _fixed_process(delta):
  if (finish.distance_to(get_global_pos()) < 32):
    emit_signal("arrive")
    queue_free()

  points = nav_board.get_simple_path(get_global_pos(), finish, false)

  var next_point = board.world_to_map(points[1])
  next_point = board.map_to_world(next_point)
  next_point.y += 32

  if points.size() > 1:
    var direction = get_direction(get_global_pos(), next_point)
    printt("move", direction)
    move(direction * speed)
    update()

func _draw():
  # if there are points to draw
  if points.size() > 1:
    for p in points:
      draw_circle(p - get_global_pos(), 8, Color(1, 0, 0)) # we draw a circle (convert to global position first)
