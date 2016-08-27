extends Node

export(String) var text = "..."
export(NodePath) var next_speech = null
export(String, MULTILINE) var action = "printt(\"hi\")"

func is_answer_action():
  return next_speech == null

func run_action(actor, player):
  if not is_answer_action():
    return

  var src = "extends Object\n\n" +\
                   "func run(actor, player):\n" +\
                   "\t" + action.replace("\n", "\n\t") + "\n"

  #print("src=\n\n########\n" + src + "\n#######\n")

  var script = GDScript.new()
  script.set_source_code(src)
  script.reload()

  var ref = Reference.new()
  ref.set_script(script)
  #printt("actor=", actor, "player=", player)
  ref.run(actor, player)

func get_next_speech():
  return get_node(next_speech)
