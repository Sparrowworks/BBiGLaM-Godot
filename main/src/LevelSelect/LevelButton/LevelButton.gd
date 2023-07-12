extends TextureButton

@export_enum("Normal", "Test", "Exam") var button_type: int = 0:
	set(val):
		button_type = val
		match button_type:
			0:
				texture_normal = load("res://assets/HyperCasual Game UI/blueBG.png")
			1:
				texture_normal = load("res://assets/HyperCasual Game UI/yellowBG.png")
			2:
				texture_normal = load("res://assets/HyperCasual Game UI/greenBG.png")

@export var level_id: String = "Lesson1":
	set(val):
		level_id = val
		check_if_level_unlocked()

@export var level: int = 1

var is_level_unlocked: bool = true

func check_if_level_unlocked():
	if DataManager.lessons_unlocked[level_id]:
		is_level_unlocked = true
		$Play.show()
		$Locked.hide()
	else:
		is_level_unlocked = false
		$Play.hide()
		$Locked.show()

func _on_pressed():
	if not is_level_unlocked:
		return

	Globals.cur_level_id = level_id
	Globals.level = level

	Composer.goto_scene_string("game",{
		"is_animated":true,
		"animation":1
	})
