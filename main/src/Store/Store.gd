extends Node2D

@onready var button_click: AudioStreamPlayer = Globals.root.get_node("ButtonClick")

@onready var items_1 = $CanvasLayer/UI/Background/Menu/Items/Items1
@onready var items_2 = $CanvasLayer/UI/Background/Menu/Items/Items2
@onready var item1 = $CanvasLayer/UI/Background/Menu/Inventory/Item1/Item1/ItemSlot
@onready var item2 = $CanvasLayer/UI/Background/Menu/Inventory/Item2/Item2/ItemSlot

@onready var coin_amount = $CanvasLayer/UI/Background/Menu/Logo/Panel/CenterContainer/HBoxContainer/CoinAmount
@onready var johnny = $Johnny

var sounds = {
	"welcome":preload("res://assets/sounds/store_welcome.mp3"),
	"buy1":preload("res://assets/sounds/store_buy1.mp3"),
	"buy2":preload("res://assets/sounds/store_buy2.mp3"),
	"sell1":preload("res://assets/sounds/sell1.mp3"),
	"sell2":preload("res://assets/sounds/sell2.mp3"),
	"no":preload("res://assets/sounds/store_no.mp3"),
	"leave":preload("res://assets/sounds/store_leave.mp3"),
}

var is_changing_page: bool = false
var cur_store_page: int = 1
var tween: Tween

var dragged_btn
var active_slot

func _ready():
	johnny.stream = sounds["welcome"]
	johnny.play()

	item1.type = DataManager.items[0]
	item2.type = DataManager.items[1]

	coin_amount.text = "x" + str(DataManager.coins)

func _on_page_button_pressed():
	if is_changing_page:
		return

	is_changing_page = true
	button_click.play()

	if cur_store_page == 1:
		switch_to_second_store()
	else:
		switch_to_first_store()

func switch_to_first_store():
	if tween:
		tween.kill()

	tween = get_tree().create_tween()
	tween.tween_property(items_2,"global_position:x",1080,0.5).set_trans(Tween.TRANS_CUBIC).from(0)
	tween.tween_property(items_1,"global_position:x",0,0.5).set_trans(Tween.TRANS_CUBIC).from(-1080)
	tween.tween_callback(
		func():
			cur_store_page = 1
			is_changing_page = false
			tween.kill()
	)

func switch_to_second_store():
	if tween:
		tween.kill()

	tween = get_tree().create_tween()
	tween.tween_property(items_1,"global_position:x",1080,0.5).set_trans(Tween.TRANS_CUBIC).from(0)
	tween.tween_property(items_2,"global_position:x",0,0.5).set_trans(Tween.TRANS_CUBIC).from(-1080)
	tween.tween_callback(
		func():
			cur_store_page = 2
			is_changing_page = false
			tween.kill()
	)

func _on_menu_button_pressed():
	if is_changing_page:
		return

	is_changing_page = true

	johnny.stream = sounds["leave"]
	johnny.play()

	DataManager.save()

	await johnny.finished

	Composer.goto_scene_string("level_select",{
		"is_animated":true,
		"animation":1
	})

func _on_store_button_drag_started(btn: ItemButton):
	if not dragged_btn:
		dragged_btn = btn

func _on_store_button_drag_ended(btn: ItemButton):
	if active_slot:
		var price = Globals.prices[btn.type]
		if price <= DataManager.coins:
			DataManager.coins -= price

			if active_slot.type != "None":
				DataManager.coins += Globals.prices[active_slot.type] / 2

			active_slot.type = btn.type
			DataManager.items[active_slot.slot] = btn.type

			$Buy.play()
			match active_slot.slot:
				0:
					johnny.stream = sounds["buy1"]
				1:
					johnny.stream = sounds["buy2"]

			johnny.play()
			coin_amount.text = "x" + str(DataManager.coins)
			DataManager.save()
		else:
			$Fail.play()
			johnny.stream = sounds["no"]
			johnny.play()

	dragged_btn = null


func _on_item_slot_slot_activated(btn):
	active_slot = btn

func _on_item_slot_slot_deactivated(btn):
	active_slot = null

func _on_item_slot_slot_pressed(btn):
	if btn.type == "None":
		return

	match active_slot.slot:
		0:
			johnny.stream = sounds["sell1"]
		1:
			johnny.stream = sounds["sell2"]

	johnny.play()

	DataManager.coins += Globals.prices[btn.type] / 2
	DataManager.items[btn.slot] = "None"
	btn.type = "None"

	coin_amount.text = "x" + str(DataManager.coins)

