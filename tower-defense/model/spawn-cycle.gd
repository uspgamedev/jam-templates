extends Node

export(int) var repetitions = 1
export(float) var spawn_time = 1
export(float) var start_delay = 2
export(PackedScene) var enemy_scene

export var health = 10
export var core_damage = 10
export var speed = 2.0
export var money = 50

signal cycle_finished

var timer = Timer.new()
var spawn_count = 1

var enemy_pool
var player

func start(player, enemy_pool):
  printt("start initial cycle delay", get_name())
  self.player = player
  self.enemy_pool = enemy_pool

  timer.set_name("Timer")
  add_child(timer)

  timer.set_wait_time(start_delay)
  timer.set_one_shot(true)

  timer.start()
  yield(timer, "timeout")
  timer.stop()

  timer.set_wait_time(spawn_time)
  timer.connect("timeout", self, "spawn_enemy")
  timer.set_one_shot(false)
  spawn_count = 1

  timer.start()

func spawn_enemy():
  printt("spawn_count=", spawn_count)
  if spawn_count > repetitions:
    timer.stop()
    emit_signal("cycle_finished")
    return

  spawn_count += 1
  yield(get_tree(), "fixed_frame")
  var enemy_spawn = enemy_scene.instance()
  enemy_spawn.set_data(health, core_damage, speed, money)

  enemy_pool.add_child(enemy_spawn)
  enemy_spawn.set_board(enemy_pool.get_parent())

  enemy_spawn.connect("arrive", player , "receive_damage")
  enemy_spawn.connect("enemy_died", player , "receive_money")
