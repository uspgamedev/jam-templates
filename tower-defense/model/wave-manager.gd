extends Node

export(float) var delta_wave_delay = 3

onready var timer = Timer.new()
onready var player = get_node("../Player")
onready var enemy_pool = get_node("../BoardNav/BoardMap/enemies")


func _ready():
  add_child(timer)
  timer.set_name("Timer")
  timer.set_one_shot(true)

func start_waves():
  printt("start_waves")
  for wave in get_children():
    if wave.get_type()== "Timer":
      continue

    printt("wave=", wave.get_name())
    timer.set_wait_time(delta_wave_delay)
    player.set_current_wave(wave.get_name())
    timer.start()
    yield(timer, "timeout")

    for cycle in wave.get_children():
      printt("cycle=", cycle.get_name())
      cycle.start(player, enemy_pool)
      yield(cycle, "cycle_finished")
