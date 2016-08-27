extends CanvasLayer

var actual_speech = null

onready var reader = get_node("DialogReader")
onready var speech_label = get_node("DialogReader/TextPanel/Text")
onready var button_panel = get_node("DialogReader/ButtonPanel")
var player

func _ready():
  reader.hide()

func init_dialog(speech):
  player = get_node("/root/main/gameplay").get_hero()
  actual_speech = speech
  update_dialog()
  reader.show()

func update_dialog():
  speech_label.clear()
  speech_label.add_text(actual_speech.speech)
  generate_buttons()

func generate_buttons():
  button_panel.clear()
  for answer in actual_speech.get_answers():
    button_panel.add_button(answer.text)


func _on_answer_button_selected( button_idx ):
  var answer = actual_speech.get_answers()[button_idx]
  if not answer.is_answer_action():
    actual_speech = answer.get_next_speech()
    update_dialog()
  else:
    answer.run_action(actual_speech.get_actor(), player)
    reader.hide()
