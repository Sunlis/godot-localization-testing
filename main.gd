extends Control

@onready var header_label: Label = %header_label
@onready var language_label: Label = %language_label
@onready var language_option: OptionButton = %language_option
@onready var amount_label: Label = %amount_label
@onready var amount_input: SpinBox = %amount_input
@onready var output_label: Label = %output_label
@onready var output_area: Label = %output_area
@onready var goal_label: Label = %goal_label

const LANGUAGES = [
  "en",
  "fr",
  "ru"
]

var _value = 0
var _language = 0

func _ready():
  _setup_language_options()
  amount_input.value_changed.connect(_amount_input_changed)
  language_option.item_selected.connect(_language_option_changed)
  _update()

func _update():
  header_label.text = tr("header_label")
  amount_label.text = tr("amount_label")
  output_label.text = tr("output_label")
  output_area.text = tr_n("output_content", "output_content_plural", _value) % _value
  var remaining = 20 - _value
  goal_label.text = tr_n("goal_content", "goal_content_plural", remaining) % remaining

func _amount_input_changed(val: int):
  _value = val
  _update()

func _setup_language_options():
  for lang in LANGUAGES:
    language_option.add_item(lang)
  language_option.select(0)
  _language = 0

func _language_option_changed(val: int):
  _language = val
  var lang_str = LANGUAGES[val]
  TranslationServer.set_locale(lang_str)
  _update()
