extends Node2D

@onready var opening: AudioStreamPlayer = Globals.root.get_node("Opening")
@onready var baldi_opening: AudioStreamPlayer = Globals.root.get_node("Baldi")
@onready var menu_theme: AudioStreamPlayer = Globals.root.get_node("Menu")
@onready var button_click: AudioStreamPlayer = Globals.root.get_node("ButtonClick")

func _ready():
	if Globals.first_open:
		Globals.first_open = false
		opening.play()
		baldi_opening.play()

		await get_tree().create_timer(10).timeout
		menu_theme.play()
	else:
		if not menu_theme.playing:
			menu_theme.play()

	$CanvasLayer/UI/Background/Control/Playtime/AnimationPlayer.play("playtime")

func _on_play_button_pressed():
	opening.stop()
	baldi_opening.stop()
	button_click.play()

	Composer.goto_scene_string("level_select",{
		"is_animated":true,
		"animation":1
	})

func _on_settings_button_pressed():
	opening.stop()
	baldi_opening.stop()
	button_click.play()

	Composer.goto_scene_string("settings",{
		"is_animated":true,
		"animation":1
	})


func _on_credits_button_pressed():
	opening.stop()
	baldi_opening.stop()
	button_click.play()

	Composer.goto_scene_string("credits",{
		"is_animated":true,
		"animation":1
	})
