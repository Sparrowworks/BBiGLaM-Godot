extends Node2D

@onready var button_click: AudioStreamPlayer = Globals.root.get_node("ButtonClick")
@onready var menu_theme: AudioStreamPlayer = Globals.root.get_node("Menu")

@onready var title = $CanvasLayer/UI/Background/Menu/Logo/Title
@onready var class_screen = $CanvasLayer/UI/Background/Menu/Panel/Class
@onready var lessons_1 = $CanvasLayer/UI/Background/Menu/Panel/Lessons1
@onready var lessons_2 = $CanvasLayer/UI/Background/Menu/Panel/Lessons2

@onready var item1 = $CanvasLayer/UI/Background/Menu/Items/Item1/ItemSlot
@onready var item2 = $CanvasLayer/UI/Background/Menu/Items/Item2/ItemSlot
@onready var coin_amount = $CanvasLayer/UI/Background/Menu/Logo/Panel/CenterContainer/HBoxContainer/CoinAmount

@onready var random_desc = $CanvasLayer/UI/Background/Menu/Panel/Class/Class3/Class3Button/Info/Desc/Desc
@onready var random_time = $CanvasLayer/UI/Background/Menu/Panel/Class/Class3/Class3Button/Info/Desc/Time

@onready var class_3_button = $CanvasLayer/UI/Background/Menu/Panel/Class/Class3/Class3Button

var classroom: int:
	set(val):
		classroom = val
		move_classroom()

var image_paths: Dictionary = {
	"bar":preload("res://assets/Items/bar.webp"),
	"apple":preload("res://assets/Items/apple.webp"),
	"clock":preload("res://assets/Items/clock.webp"),
	"keys":preload("res://assets/Items/key.webp"),
	"cheat":preload("res://assets/Items/cheat.webp"),
	"scissors":preload("res://assets/Items/scissors.webp")
}

var is_switching = false
var classroom_tween: Tween

func _ready():
	if not menu_theme.playing:
		menu_theme.play()

	item1.type = DataManager.items[0]
	item2.type = DataManager.items[1]

	coin_amount.text = "x" + str(DataManager.coins)

	if DataManager.can_play_daily:
		class_3_button.disabled = false

		random_desc.text = "New test every day with bonus rewards!"
		random_time.text = "Tap this button to play!"
	else:
		class_3_button.disabled = true

		if DataManager.has_failed_daily:
			random_desc.text = "You've failed the daily challenge..."
		else:
			random_desc.text = "You've finished the daily challenge!"

		if Globals.current_time == 0:
			random_time.text = "Failed to connect with the server."
			return

		$Timer.start()
		update_timer()

func update_timer():
	var time = Globals.root.get_difference()
	if time == []:
		$Timer.stop()
		random_time.text = "Tap this button to play!"
		class_3_button.disabled = false
		return

	random_time.text = "Come back in: %02d:%02d:%02d" % time

func _on_timer_timeout():
	update_timer()

func move_classroom():
	if is_switching:
		return

	is_switching = true

	if classroom_tween != null:
		classroom_tween.kill()

	classroom_tween = get_tree().create_tween()
	classroom_tween.tween_property(class_screen,"global_position:x",-1080,0.5).set_trans(Tween.TRANS_CUBIC).from(60)
	match classroom:
		1:
			classroom_tween.tween_property(lessons_1,"global_position:x",0,0.5).set_trans(Tween.TRANS_CUBIC).from(1080)
		2:
			classroom_tween.tween_property(lessons_2,"global_position:x",0,0.5).set_trans(Tween.TRANS_CUBIC).from(1080)

	await classroom_tween.finished
	classroom_tween.kill()

	title.text = "Select a lesson:"
	is_switching = false

func _on_back_button_pressed():
	if is_switching:
		return

	button_click.play()

	is_switching = true

	if classroom_tween != null:
		classroom_tween.kill()

	classroom_tween = get_tree().create_tween()
	match classroom:
		1:
			classroom_tween.tween_property(lessons_1,"global_position:x",1080,0.5).set_trans(Tween.TRANS_CUBIC).from(0)
		2:
			classroom_tween.tween_property(lessons_2,"global_position:x",1080,0.5).set_trans(Tween.TRANS_CUBIC).from(0)

	classroom_tween.tween_property(class_screen,"global_position:x",60,0.5).set_trans(Tween.TRANS_CUBIC).from(-1080)
	await classroom_tween.finished
	classroom_tween.kill()

	title.text = "Select a classroom:"
	is_switching = false


func _on_class_1_button_pressed():
	button_click.play()

	classroom = 1


func _on_class_2_button_pressed():
	button_click.play()

	classroom = 2


func _on_class_3_button_pressed():
	if not DataManager.can_play_daily:
		return

	button_click.play()
	DataManager.can_play_daily = false
	DataManager.has_failed_daily = true
	DataManager.last_played_daily = int(Time.get_unix_time_from_system()) + 86400

	DataManager.save()
	Globals.root.calculate_difference()

	Globals.cur_level_id = "Random";
	Globals.level = -1
	Composer.goto_scene_string("game",{
		"is_animated":true,
		"animation":1
	})

func _on_shop_button_pressed():
	button_click.play()

	Composer.goto_scene_string("store",{
		"is_animated":true,
		"animation":1
	})


func _on_menu_button_pressed():
	button_click.play()

	Composer.goto_scene_string("main_menu",{
		"is_animated":true,
		"animation":1,
	})

