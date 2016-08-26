extends Object

var node

func _init(actor):
  node = actor

func _action(params):
  printt("init dialog node=", node)
  var reader = node.get_node("/root/main/HUD")
  reader.init_dialog(node.get_node("Conversation/Speech1"))

func run(params):
  self._action(params)
