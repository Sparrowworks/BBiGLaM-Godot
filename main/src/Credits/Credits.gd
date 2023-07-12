extends Node2D

@onready var menu_theme: AudioStreamPlayer = Globals.root.get_node("Menu")
@onready var credits_theme: AudioStreamPlayer = Globals.root.get_node("Credits")
@onready var button_click: AudioStreamPlayer = Globals.root.get_node("ButtonClick")

func _ready():
	menu_theme.stop()
	credits_theme.play()

func _on_menu_button_pressed():
	credits_theme.stop()
	button_click.play()

	Composer.goto_scene_string("main_menu",{
		"is_animated":true,
		"animation":1
	})
