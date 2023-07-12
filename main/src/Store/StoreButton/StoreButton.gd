class_name ItemButton
extends TextureButton

signal drag_started(btn: ItemButton)
signal drag_ended(btn: ItemButton)

@export var reverse_placement = false:
	set(val):
		reverse_placement = val

		if reverse_placement:
			$HBoxContainer.move_child($HBoxContainer/Image,1)
		else:
			$HBoxContainer.move_child($HBoxContainer/Image,0)

@export var drag_intensity: float = 25
@export_enum("Bar","Apple","Clock","Keys","Sheet","Scissors") var type = "Bar":
	set(val):
		type = val

		draw_button()

@onready var item = $HBoxContainer/Image/Frame/Item

@onready var item_name = $HBoxContainer/Text/ItemName
@onready var desc = $HBoxContainer/Text/Desc
@onready var price = $HBoxContainer/Text/Price


var tween: Tween
var is_held: bool = false

func _ready():
	if type == "Bar":
		draw_button()

func draw_button():
	if not item:
		await ready

	item.texture = Globals.item_images[type]
	item_name.text = Globals.info[type]["name"]
	desc.text = Globals.info[type]["desc"]
	price.text = "Price: " + str(Globals.prices[type]) + " Quarters"
	print(Globals.prices[type], " ", type)


func _on_button_down():
	is_held = true
	drag_started.emit(self)
	set_process(true)


func _on_button_up():
	is_held = false
	drag_ended.emit(self)
	set_process(false)

	if tween:
		tween.kill()

	tween = get_tree().create_tween()
	tween.tween_property(item,"position",Vector2(32,32),.5).set_trans(Tween.TRANS_ELASTIC)
	tween.tween_callback(tween.kill)

func _process(delta):
	if is_held:
		item.global_position = Vector2(
			lerp(item.global_position.x,get_global_mouse_position().x, delta * drag_intensity),
			lerp(item.global_position.y,get_global_mouse_position().y, delta * drag_intensity)
		)
