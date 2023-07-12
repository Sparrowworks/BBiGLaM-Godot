extends Node

var root: Node2D = null

var first_open: bool = true
var cur_level_id: String = ""
var level: int = 1

var current_time = 0

var wrong_answered = 0
var correct_answered = 0
var bully_robberies = 0
var was_level_passed = false

var bus_indexes = {
	"master":AudioServer.get_bus_index("Master"),
	"music":AudioServer.get_bus_index("Music"),
	"sfx":AudioServer.get_bus_index("SFX"),
}

var item_images = {
	"Bar":preload("res://assets/Items/bar.webp"),
	"Apple":preload("res://assets/Items/apple.webp"),
	"Clock":preload("res://assets/Items/clock.webp"),
	"Keys":preload("res://assets/Items/key.webp"),
	"Sheet":preload("res://assets/Items/cheat.webp"),
	"Scissors":preload("res://assets/Items/scissors.webp"),
}

var info = {
	"Bar":{
		"name":"Zesty Bar",
		"desc":"Get rid of the Bully!",
	},
	"Apple":{
		"name":"Apple",
		"desc":"Give it to Baldi to please him!",
	},
	"Clock":{
		"name":"Clock",
		"desc":"Get extra time on a test!",
	},
	"Keys":{
		"name":"Principal Keys",
		"desc":"Escape the Detention!",
	},
	"Sheet":{
		"name":"Cheat Sheet",
		"desc":"Don't use it near Principal!",
	},
	"Scissors":{
		"name":"Scissors",
		"desc":"Get rid of Playtime!",
	},
}

var prices = {
	"Bar":25,
	"Apple":30,
	"Clock":50,
	"Keys":40,
	"Sheet":15,
	"Scissors":30
}
