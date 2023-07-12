class_name LetterButton
extends TextureButton

signal letter_pressed(btn: LetterButton)

@export var pressable: bool = true
@export_enum("a","b","c","d","e","f","g","h","i","j","k","l","m","n","o","p","q","r","s","t","u","v","w","x","y","z","\'","-") var letter = "a":
	set(val):
		letter = val
		set_letter()

@onready var letter_text = $CenterContainer/Letter
@onready var button_click: AudioStreamPlayer = Globals.root.get_node("SmallClick")

func set_letter():
	if not letter_text:
		await ready

	letter_text.text = letter.to_upper()


func _on_pressed():
	if not pressable:
		return

	button_click.play()
	letter_pressed.emit(self)
