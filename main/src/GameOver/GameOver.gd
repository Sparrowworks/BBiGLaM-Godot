extends Node2D

@onready var button_click: AudioStreamPlayer = Globals.root.get_node("ButtonClick")

@onready var level = $CanvasLayer/UI/Menu/Level
@onready var quote_text = $CanvasLayer/UI/Menu/Quote
@onready var title = $CanvasLayer/UI/Menu/Title

@onready var passed = $CanvasLayer/UI/Menu/VBoxContainer/Passed
@onready var correct = $CanvasLayer/UI/Menu/VBoxContainer/Correct
@onready var wrong = $CanvasLayer/UI/Menu/VBoxContainer/Wrong
@onready var bully = $CanvasLayer/UI/Menu/VBoxContainer/Bully

@onready var total = $CanvasLayer/UI/Menu/Total

var quotes = [
	"I knew you'd succeed!",
	"You're amazing!",
	"That was fun!",
	"You're my best student!",
	"You're incredible!",
	"See me after class...",
	"You need to improve...",
	"Better luck next time...",
	"You need some more practice!"
]

var level_finish_prize: Dictionary = {
		"Lesson1":1,
		"Lesson2":1,
		"Lesson3":1,
		"Lesson4":1,
		"Lesson5":1,
		"Lesson6":1,
		"Test1":5,
		"Test2":5,
		"Test3":5,
		"Test4":5,
		"Exam1":10,

		"Lesson7":1,
		"Lesson8":1,
		"Lesson9":1,
		"Lesson10":1,
		"Lesson11":1,
		"Lesson12":1,
		"Test5":5,
		"Test6":5,
		"Test7":5,
		"Test8":5,
		"Exam2":10,

		"Random":15
}

var test_question_rewards: Dictionary = {
	"Lesson1":0,
	"Lesson2":0,
	"Lesson3":0,
	"Lesson4":0,
	"Lesson5":0,
	"Lesson6":0,
	"Lesson7":0,
	"Lesson8":0,
	"Lesson9":0,
	"Lesson10":0,
	"Lesson11":0,
	"Lesson12":0,

	"Test1":2,
	"Test2":2,
	"Test3":3,
	"Test4":3,
	"Exam1":5,

	"Test5":2,
	"Test6":2,
	"Test7":3,
	"Test8":3,
	"Exam2":5,

	"Random":3
}

var next_level: Dictionary = {
	"Lesson1":["Test1",1],
	"Test1":["Lesson2",2],
	"Lesson2":["Lesson3",3],
	"Lesson3":["Test2",2],
	"Test2":["Lesson4",4],
	"Lesson4":["Test3",3],
	"Test3":["Lesson5",5],
	"Lesson5":["Lesson6",6],
	"Lesson6":["Test4",4],
	"Test4":["Exam1",1],
	"Exam1":["Lesson7",7],

	"Lesson7":["Test5",5],
	"Test5":["Lesson8",8],
	"Lesson8":["Test6",6],
	"Test6":["Lesson9",9],
	"Lesson9":["Lesson10",10],
	"Lesson10":["Test7",7],
	"Test7":["Lesson11",11],
	"Lesson11":["Lesson12",12],
	"Lesson12":["Test8",8],
	"Test8":["Exam2",2],
	"Exam2":[],

	"Random":[]
}

func _ready():
	if Globals.was_level_passed:
		$Win.play()

		var num = randi_range(1,100)
		if num <= 50:
			$BaldiWin1.play()
		else:
			$BaldiWin2.play()
	else:
		$Lose.play()

	set_up_labels()

func set_up_labels():
	if Globals.was_level_passed:
		if Globals.cur_level_id.contains("Lesson"):
			level.text = "Lesson " + str(Globals.level) + " Passed!"
		elif Globals.cur_level_id.contains("Test"):
			level.text = "Test " + str(Globals.level) + " Passed!"
		elif Globals.cur_level_id.contains("Exam"):
			level.text = "Exam " + str(Globals.level) + " Passed!"
	else:
		if Globals.cur_level_id.contains("Lesson"):
			level.text = "Lesson " + str(Globals.level) + " Failed!"
		elif Globals.cur_level_id.contains("Test"):
			level.text = "Test " + str(Globals.level) + " Failed!"
		elif Globals.cur_level_id.contains("Exam"):
			level.text = "Exam " + str(Globals.level) + " Failed!"

	if Globals.bully_robberies > 0:
		bully.show()
	else:
		bully.hide()

	random_quote()
	set_up_rewards()

func random_quote():
	var quote = ""

	if Globals.was_level_passed:
		quote = quotes[randi_range(0,4)]
	else:
		quote = quotes[randi_range(5,8)]

	quote_text.text = "\"" + quote + "\"~Baldi"

func set_up_rewards():
	var answered_coins = Globals.correct_answered * test_question_rewards[Globals.cur_level_id]
	var wrong_coins = 0

	if Globals.wrong_answered > 0:
		wrong_coins = clamp(Globals.wrong_answered * test_question_rewards[Globals.cur_level_id] / 2,1,999)

	var bully_coins = Globals.bully_robberies * 5
	var total_coins = clamp(level_finish_prize[Globals.cur_level_id] + answered_coins - wrong_coins - bully_coins,0,999)

	if Globals.was_level_passed:
		if Globals.level == -1:
			passed.text = "+ Random Challenge Passed (+20 Quarters)"
			correct.text = "+ " + str(Globals.correct_answered) + " Correct Answers"
			wrong.text = "- " + str(Globals.wrong_answered) + " Wrong Answers"
			bully.text = "- " + str(Globals.bully_robberies) + " Bully Robberies (-" + str(bully_coins) + " Quarters)"
			total.text = "Total: + " + str(20 - bully_coins) + " Quarters"

			DataManager.coins += 20 - bully_coins

			$CanvasLayer/UI/Menu/Next.hide()
			$CanvasLayer/UI/Menu/Restart.hide()
		else:
			if Globals.cur_level_id.contains("Lesson"):
				passed.text = "+ Lesson Passed (+1 Quarter)"
				correct.text = "+ " + str(Globals.correct_answered) + " Correct Answers"
				wrong.text = "+ " + str(Globals.wrong_answered) + " Answers Learned"
				total.text = "Total: +1 Quarter"

				DataManager.coins += 1
			else:
				if Globals.cur_level_id.contains("Test"):
					passed.text = "+ Test Passed (+" + str(level_finish_prize[Globals.cur_level_id]) + " Quarters)"
				else:
					passed.text = "+ Exam Passed (+" + str(level_finish_prize[Globals.cur_level_id]) + " Quarters)"

				correct.text = "+ " + str(Globals.correct_answered) + " Correct Answers (+" + str(answered_coins) + " Quarters)"
				wrong.text = "+ " + str(Globals.wrong_answered) + " Wrong Answers (-" + str(wrong_coins) + " Quarters)"
				bully.text = "- " + str(Globals.bully_robberies) + " Bully Robberies (-" + str(bully_coins) + " Quarters)"
				total.text = "Total: +" + str(total_coins) + " Quarters"

				DataManager.coins += total_coins

			$CanvasLayer/UI/Menu/Next.show()
			$CanvasLayer/UI/Menu/Restart.hide()

		unlock_next()
	else:
		if Globals.level == -1:
			passed.text = "+ Random Challenge Failed"
			correct.text = "+ " + str(Globals.correct_answered) + " Correct Answers"
			wrong.text = "+ " + str(Globals.wrong_answered) + " Wrong Answers "
			bully.text = "- " + str(Globals.bully_robberies) + " Bully Robberies (-" + str(bully_coins) + " Quarters)"
			total.text = "Total: -" + str(bully_coins) + " Quarters"

			$CanvasLayer/UI/Menu/Next.hide()
			$CanvasLayer/UI/Menu/Restart.hide()
		else:
			if Globals.cur_level_id.contains("Test"):
				passed.text = "+ Test Failed (+0 Quarters)"
			else:
				passed.text = "+ Exam Failed (+0 Quarters)"

			correct.text = "+ " + str(Globals.correct_answered) + " Correct Answers"
			wrong.text = "- " + str(Globals.wrong_answered) + " Wrong Answers"
			bully.text = "- " + str(Globals.bully_robberies) + " Bully Robberies (-" + str(bully_coins) + " Quarters)"
			total.text = "Total: +0 Quarters"

			$CanvasLayer/UI/Menu/Next.hide()
			$CanvasLayer/UI/Menu/Restart.show()

	DataManager.save()

func unlock_next():
	var next = next_level[Globals.cur_level_id]

	if next == []:
		$CanvasLayer/UI/Menu/Next.hide()
	else:
		DataManager.lessons_unlocked[next[0]] = true

func _on_next_pressed():
	button_click.play()

	Globals.cur_level_id = next_level[Globals.cur_level_id][0]
	Globals.level = next_level[Globals.cur_level_id][1]

	Composer.goto_scene_string("game",{
		"is_animated":true,
		"animation":1
	})

func _on_restart_pressed():
	button_click.play()

	Composer.goto_scene_string("game",{
		"is_animated":true,
		"animation":1
	})

func _on_menu_pressed():
	button_click.play()

	Composer.goto_scene_string("level_select",{
		"is_animated":true,
		"animation":1
	})
