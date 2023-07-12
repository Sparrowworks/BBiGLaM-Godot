class_name PlaytimeButton
extends TextureButton

signal playtime_pressed(btn: PlaytimeButton)

@export_range(1,10) var num = 1:
	set(val):
		num = val
		$CenterContainer/Label.text = str(num)

@onready var button_click: AudioStreamPlayer = Globals.root.get_node("SmallClick")

var can_press: bool = false

func correct():
	$AnimationPlayer.play("Fade")

func reset():
	$AnimationPlayer.stop()
	can_press = true
	modulate = Color.WHITE

func _on_pressed():
	if not can_press:
		return

	button_click.play()
	can_press = false
	playtime_pressed.emit(self)
