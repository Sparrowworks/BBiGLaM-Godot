extends Node

var coins: int = 0:
	set(val):
		coins = clamp(val,0,999)

var items: Array = ["None","None"]

var lessons_unlocked: Dictionary = {
	"Lesson1":true,
	"Test1":false,
	"Lesson2":false,
	"Lesson3":false,
	"Test2":false,
	"Lesson4":false,
	"Test3":false,
	"Lesson5":false,
	"Lesson6":false,
	"Test4":false,
	"Exam1":false,

	"Lesson7":true,
	"Test5":false,
	"Lesson8":false,
	"Test6":false,
	"Lesson9":false,
	"Lesson10":false,
	"Test7":false,
	"Lesson11":false,
	"Lesson12":false,
	"Test8":false,
	"Exam2":false,
}

var settings: Dictionary = {
	"master_volume":100,
	"music_volume":100,
	"sfx_volume":100
}

var has_failed_daily: bool = false
var can_play_daily: bool = true
var last_played_daily: int = 0

const FILE_PATH: String = "user://SaveGame.save"

func _input(event: InputEvent):
	if event.is_action_pressed("cheat_unlock") and Composer.get_scene_name().find("LevelSelect") == 0:
		for level in lessons_unlocked.keys():
			lessons_unlocked[level] = true

		Composer.reload_current_scene()

	if event.is_action_pressed("cheat_daily") and Composer.get_scene_name().find("LevelSelect") == 0:
		can_play_daily = true
		has_failed_daily = false
		last_played_daily = 0

		Composer.reload_current_scene()

	if event.is_action_pressed("cheat_money"):
		coins = 999

func get_save_dict() -> Dictionary:
	var dict = {
		"coins":coins,
		"items":items,
		"lessons_unlocked":lessons_unlocked,
		"has_failed_daily":has_failed_daily,
		"last_played_daily":last_played_daily,
		"can_play_daily":can_play_daily,
		"settings":settings
	}

	var data: String = JSON.stringify(dict)
	var hash: String = data.sha256_text()
	dict["hash"] = hash

	return dict

func get_empty_save_dict() -> Dictionary:
	var dict = {
		"coins":0,
		"items":["None","None"],
		"can_play_daily":true,
		"has_failed_daily":false,
		"last_played_daily":0,
		"settings":{
			"master_volume":100,
			"music_volume":100,
			"sfx_volume":100
		},
		"lessons_unlocked":{
			"Lesson1":true,
			"Test1":false,
			"Lesson2":false,
			"Lesson3":false,
			"Test2":false,
			"Lesson4":false,
			"Test3":false,
			"Lesson5":false,
			"Lesson6":false,
			"Test4":false,
			"Exam1":false,

			"Lesson7":true,
			"Test5":false,
			"Lesson8":false,
			"Test6":false,
			"Lesson9":false,
			"Lesson10":false,
			"Test7":false,
			"Lesson11":false,
			"Lesson12":false,
			"Test8":false,
			"Exam2":false,
		},
	}

	var data: String = JSON.stringify(dict)
	var hash: String = data.sha256_text()
	dict["hash"] = hash

	return dict

func get_new_password() -> String:
	return str(int(Time.get_unix_time_from_system()))

func get_password() -> String:
	return str(FileAccess.get_modified_time(FILE_PATH))

func create_new_empty_save():
	print(get_new_password())
	var file = FileAccess.open_encrypted_with_pass(FILE_PATH,FileAccess.WRITE,get_new_password())

	file.store_line(JSON.stringify(get_save_dict()))
	file.close()

func reset_data():
	create_new_empty_save()
	save()

func save():
	if not FileAccess.file_exists(FILE_PATH):
		create_new_empty_save()
		return


	var file = FileAccess.open_encrypted_with_pass(FILE_PATH,FileAccess.WRITE,get_new_password())

	if not file:
		create_new_empty_save()
		return

	file.store_line(JSON.stringify(get_save_dict()))
	file.close()

func load():
	if not FileAccess.file_exists(FILE_PATH):
		create_new_empty_save()
		return

	var file = FileAccess.open_encrypted_with_pass(FILE_PATH,FileAccess.READ,get_password())

	if not file:
		create_new_empty_save()
		return

	var data: Dictionary = JSON.parse_string(file.get_as_text())
	file.close()

	var hash: String = data["hash"]
	data.erase("hash")
	var dict_str = JSON.stringify(data)
	var new_hash = dict_str.sha256_text()

	if hash != new_hash:
		create_new_empty_save()
		return

	coins = data["coins"]
	items = data["items"]
	has_failed_daily = data["has_failed_daily"]
	last_played_daily = data["last_played_daily"]
	can_play_daily = data["can_play_daily"]
	lessons_unlocked = data["lessons_unlocked"]
	settings = data["settings"]
