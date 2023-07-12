class_name SweepButton
extends TextureButton

signal trash_pressed(btn: SweepButton)

@export_enum("1","2","3","4") var type = "1":
	set(val):
		type = val

		match type:
			"1":
				texture_normal = load("res://assets/Items/bar.webp")
			"2":
				texture_normal = load("res://assets/Items/soda.webp")
			"3":
				texture_normal = load("res://assets/Items/tape.webp")
			"4":
				texture_normal = load("res://assets/Items/eraser.webp")

@onready var button_click: AudioStreamPlayer = Globals.root.get_node("SmallClick")

var can_press: bool = false

func reset():
	type = str(randi_range(1,4))
	can_press = true
	modulate = Color.WHITE

func _on_pressed():
	if not can_press:
		return

	button_click.play()
	can_press = false
	trash_pressed.emit(self)
	$AnimationPlayer.play("Fade")
