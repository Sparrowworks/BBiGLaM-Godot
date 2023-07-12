class_name ItemSlot
extends TextureButton

@export var slot = 0
@export_enum("None","Bar","Apple","Clock","Keys","Sheet","Scissors") var type = "None":
	set(val):
		type = val

		draw_item()

signal slot_activated(btn: ItemSlot)
signal slot_deactivated(btn: ItemSlot)
signal slot_pressed(btn: ItemSlot)

@onready var item = $Item

func _on_mouse_entered():
	slot_activated.emit(self)

func _on_mouse_exited():
	slot_deactivated.emit(self)

func _on_pressed():
	slot_pressed.emit(self)

func draw_item():
	if not item:
		await ready

	if type == "None":
		item.texture = null
		return

	item.texture = Globals.item_images[type]
