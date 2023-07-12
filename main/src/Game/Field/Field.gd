class_name FieldButton
extends TextureButton

signal field_pressed(btn: FieldButton)

@export var letter_held = ""

@onready var letter_text = $CenterContainer/Letter
@onready var button_click: AudioStreamPlayer = Globals.root.get_node("SmallClick")

var btn: LetterButton = null

func update_letter(button: LetterButton, letter: String):
	letter_held = letter

	btn = button
	letter_text.text = letter_held.to_upper()

func fast_update(letter: String):
	letter_held = letter
	letter_text.text = letter_held.to_upper()

func quiet_update(letter: String):
	letter_held = letter

func clear_letter():
	letter_held = ""
	btn.show()
	btn.disabled = false
	btn.modulate = Color.WHITE

	letter_text.text = ""

func _on_pressed():
	if letter_held == "":
		return

	button_click.play()
	field_pressed.emit(self)
