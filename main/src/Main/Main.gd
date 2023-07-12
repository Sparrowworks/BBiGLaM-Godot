extends Node2D

@onready var time_request = $HTTPRequest

func _ready():
	randomize()

	DataManager.load()

	AudioServer.set_bus_volume_db(Globals.bus_indexes["master"],linear_to_db(DataManager.settings["master_volume"]/100))
	AudioServer.set_bus_volume_db(Globals.bus_indexes["music"],linear_to_db(DataManager.settings["music_volume"]/100))
	AudioServer.set_bus_volume_db(Globals.bus_indexes["sfx"],linear_to_db(DataManager.settings["sfx_volume"]/100))

	Globals.root = self

	get_time_request()

	Composer.goto_scene_string("main_menu",{
		"is_animated":true,
		"animation":1,
		"fade_in_duration":1,
		"fade_out_duration":1,
	})

func _notification(what):
	if what == NOTIFICATION_WM_CLOSE_REQUEST:
		DataManager.save()
		get_tree().quit()

func get_time_request():
	var error = time_request.request("http://worldtimeapi.org/api/ip")

	if error != OK:
		Globals.current_time = 0
		return

func _on_time_request_request_completed(result, response_code, headers, body):
	var json = JSON.new()
	json.parse(body.get_string_from_utf8())
	var response = json.get_data()

	Globals.current_time = int(response["unixtime"])

	$Timer.start()

func get_difference():
	var difference = DataManager.last_played_daily - Globals.current_time

	if difference < 0:
		return []

	var hours = difference / 3600
	var minutes = (difference - (hours * 3600)) / 60
	var seconds = (difference - (hours * 3600 + minutes * 60))

	return [hours, minutes, seconds]

func calculate_difference():
	if $Timer.time_left <= 0:
		$Timer.start()

	var difference = DataManager.last_played_daily - Globals.current_time

	if difference <= 0:
		$Timer.stop()
		DataManager.can_play_daily = true
		DataManager.save()
		return

	DataManager.last_played_daily -= 1

func _on_timer_timeout():
	calculate_difference()
