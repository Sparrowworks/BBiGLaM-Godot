extends Node2D

@onready var button_click: AudioStreamPlayer = Globals.root.get_node("ButtonClick")
@onready var menu_theme: AudioStreamPlayer = Globals.root.get_node("Menu")

@onready var master_text = $CanvasLayer/UI/Menu/Master/MasterText
@onready var master_slider = $CanvasLayer/UI/Menu/Master/Slider/MasterSlider

@onready var music_text = $CanvasLayer/UI/Menu/Music/MusicText
@onready var music_slider = $CanvasLayer/UI/Menu/Music/Slider/MusicSlider

@onready var sfx_text = $CanvasLayer/UI/Menu/SFX/SfxText
@onready var sfx_slider = $CanvasLayer/UI/Menu/SFX/Slider/SfxSlider

@onready var warning = $CanvasLayer/UI/Warning

var is_warning_shown = false

func _ready():
	if not menu_theme.playing:
		menu_theme.play()

	master_slider.value = DataManager.settings["master_volume"]
	music_slider.value = DataManager.settings["music_volume"]
	sfx_slider.value = DataManager.settings["sfx_volume"]

	master_text.text = "Master Volume: " + str(master_slider.value)
	music_text.text = "Music Volume: " + str(music_slider.value)
	sfx_text.text = "SFX Volume: " + str(sfx_slider.value)


func _on_master_slider_drag_ended(value_changed):
	if not value_changed:
		return

	DataManager.settings["master_volume"] = master_slider.value
	AudioServer.set_bus_volume_db(Globals.bus_indexes["master"],linear_to_db(master_slider.value/100))
	master_text.text = "Master Volume: " + str(master_slider.value)


func _on_music_slider_drag_ended(value_changed):
	if not value_changed:
		return

	DataManager.settings["music_volume"] = music_slider.value
	AudioServer.set_bus_volume_db(Globals.bus_indexes["music"],linear_to_db(music_slider.value/100))
	music_text.text = "Music Volume: " + str(music_slider.value)


func _on_sfx_slider_drag_ended(value_changed):
	if not value_changed:
		return

	DataManager.settings["sfx_volume"] = sfx_slider.value
	AudioServer.set_bus_volume_db(Globals.bus_indexes["sfx"],linear_to_db(sfx_slider.value/100))
	sfx_text.text = "SFX Volume: " + str(sfx_slider.value)


func _on_reset_button_pressed():
	if is_warning_shown:
		return

	is_warning_shown = true
	button_click.play()

	warning.show()


func _on_menu_button_pressed():
	if is_warning_shown:
		return

	button_click.play()
	DataManager.save()

	Composer.goto_scene_string("main_menu",{
		"is_animated":true,
		"animation":1,
	})


func _on_yes_pressed():
	DataManager.create_new_empty_save()

	is_warning_shown = false
	warning.hide()


func _on_no_pressed():
	is_warning_shown = false
	warning.hide()
