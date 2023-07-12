class_name PompButton
extends TextureButton

signal pomp_pressed(btn: PompButton)

@export_range(1,9) var num = 1:
	set(val):
		num = val
		$CenterContainer/Label.text = str(num)

@onready var button_click: AudioStreamPlayer = Globals.root.get_node("SmallClick")

var can_press: bool = false

func reset():
	can_press = true

func _on_pressed():
	if not can_press:
		return

	button_click.play()

	can_press = false
	pomp_pressed.emit(self)
