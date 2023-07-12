extends Node2D

@onready var button_click: AudioStreamPlayer = Globals.root.get_node("ButtonClick")
@onready var letter_button_scene = preload("res://src/Game/LetterButton/LetterButton.tscn")
@onready var fake_letter_scene = preload("res://src/Game/FakeLetter/FakeLetter.tscn")
@onready var field_scene = preload("res://src/Game/Field/Field.tscn")

@onready var logos = $Logos

@onready var game_title = $CanvasLayer/UI/Game/TopBar/Text/GameTitle
@onready var play_img = $CanvasLayer/UI/Game/TopBar/Buttons/MusicButton/Play

@onready var item_slot1 = $CanvasLayer/UI/Game/LogoPanel/Item1Container/ItemSlot
@onready var item_slot2 = $CanvasLayer/UI/Game/LogoPanel/Item2Container/ItemSlot

@onready var amount_text = $CanvasLayer/UI/Game/Amount
@onready var mistakes_text = $CanvasLayer/UI/Game/Mistakes

@onready var logo_img = $CanvasLayer/UI/Game/LogoPanel/LogoBG/CenterContainer/Logo
@onready var correct = $CanvasLayer/UI/Game/LogoPanel/LogoBG/CenterContainer/Correct
@onready var wrong = $CanvasLayer/UI/Game/LogoPanel/LogoBG/CenterContainer/Wrong

@onready var time_text = $CanvasLayer/UI/Game/Time
@onready var annoucement_text = $CanvasLayer/UI/Game/Time/AnnoucementLabel

@onready var field_zone = $CanvasLayer/UI/Game/FieldZone
@onready var letter_zone = $CanvasLayer/UI/Game/LetterZone
@onready var fake_letters = $CanvasLayer/UI/FakeLetters

@onready var test_timer = $Test

@onready var enemy_msg = $CanvasLayer/UI/EnemyMsg
@onready var enemy_title = $CanvasLayer/UI/EnemyMsg/VBoxContainer/Title
@onready var enemy_desc = $CanvasLayer/UI/EnemyMsg/VBoxContainer/Desc

@onready var baldi_sound = $Sounds/Baldi/BaldiSound

var baldi_sounds = {
	"start":"res://assets/sounds/baldi_start.mp3",
	"again":"res://assets/sounds/baldi_again.mp3",
	"apple":"res://assets/sounds/baldi_apple.mp3",
	"fail":"res://assets/sounds/baldi_fail.mp3",
	"help":"res://assets/sounds/baldi_help.mp3",
	"praise1":"res://assets/sounds/baldi_praise1.mp3",
	"praise2":"res://assets/sounds/baldi_praise2.mp3",
	"praise3":"res://assets/sounds/baldi_praise3.mp3",
	"praise4":"res://assets/sounds/baldi_praise4.mp3",
}

@onready var bully_img = $CanvasLayer/UI/Game/LogoPanel/LogoBG/CenterContainer/Bully/Bully
@onready var bully_anim = $CanvasLayer/UI/Game/LogoPanel/LogoBG/CenterContainer/Bully/Bully/AnimationPlayer
@onready var bully_sound = $Sounds/Bully/BullySound

var bully_sounds = {
	"spawn":"res://assets/sounds/bully.mp3",
	"bored":"res://assets/sounds/bully_bored.mp3",
	"cash":"res://assets/sounds/bully_cash.mp3",
	"item":"res://assets/sounds/bully_item.mp3",
	"nopass":"res://assets/sounds/bully_nopass.mp3",
}

@onready var principal_img = $CanvasLayer/UI/Game/LogoPanel/LogoBG/CenterContainer/Principal/Principal
@onready var principal_anim = $CanvasLayer/UI/Game/LogoPanel/LogoBG/CenterContainer/Principal/Principal/AnimationPlayer
@onready var principal_sound = $Sounds/Principal/PrincipalSound

var principal_sounds = {
	"spawn":"res://assets/sounds/principal.mp3",
	"15":"res://assets/sounds/principal_15.mp3",
	"30":"res://assets/sounds/principal_30.mp3",
	"60":"res://assets/sounds/principal_60.mp3",
}

@onready var playtime_img = $CanvasLayer/UI/Game/LogoPanel/LogoBG/CenterContainer/Playtime/Playtime
@onready var playtime_anim = $CanvasLayer/UI/Game/LogoPanel/LogoBG/CenterContainer/Playtime/Playtime/AnimationPlayer
@onready var playtime_sound = $Sounds/Playtime/PlaytimeSound
@onready var playtime_panel = $CanvasLayer/UI/PlaytimePanel

var playtime_sounds = {
	"laugh":"res://assets/sounds/playtime_laugh.mp3",
	"spawn":"res://assets/sounds/playtime.mp3",
	"congrats":"res://assets/sounds/playtime_congrats.mp3",
	"oops":"res://assets/sounds/playtime_oops.mp3",
	"sad":"res://assets/sounds/playtime_sad.mp3",
}

@onready var sweep_img = $CanvasLayer/UI/Game/LogoPanel/LogoBG/CenterContainer/Sweep/Sweep
@onready var sweep_anim = $CanvasLayer/UI/Game/LogoPanel/LogoBG/CenterContainer/Sweep/Sweep/AnimationPlayer
@onready var sweep_sound = $Sounds/Sweep/SweepSound
@onready var sweep_panel = $CanvasLayer/UI/SweepPanel

@onready var pomp_img = $CanvasLayer/UI/Game/LogoPanel/LogoBG/CenterContainer/Pomp/Pomp
@onready var pomp_anim = $CanvasLayer/UI/Game/LogoPanel/LogoBG/CenterContainer/Pomp/Pomp/AnimationPlayer
@onready var pomp_panel = $CanvasLayer/UI/PompPanel
@onready var pomp_sound = $Sounds/Pomp/PompSound
@onready var angry_pomp = $CanvasLayer/UI/Game/LogoPanel/LogoBG/CenterContainer/Pomp/AngryPomp

var pomp_sounds = {
	"spawn":"res://assets/sounds/pomp.mp3",
	"end":"res://assets/sounds/pomp_end.mp3",
	"correct":"res://assets/sounds/pomp_correct.mp3",
	"wrong":"res://assets/sounds/pomp_scream.mp3",
	"add":"res://assets/sounds/pomp_add.mp3",
}

enum GAME_TYPES {
	LESSON = 1,
	TEST = 2,
	EXAM = 3,
	RANDOM = 4,
}

var game_type: GAME_TYPES = GAME_TYPES.LESSON

enum GAME_STATES {
	GENERATING = 1,
	READY = 2,
	ENEMY = 3,
	END = 4,
	CHEAT = 5,
	DETENTION = 6,
}

var game_state: GAME_STATES = GAME_STATES.GENERATING

enum ENEMIES {
	NONE = 0,
	PLAYTIME = 1,
	PRINCIPAL = 2,
	BULLY = 3,
	SWEEP = 4,
	POMP = 5,
}

var enemy: ENEMIES = ENEMIES.NONE

var needed_phrase: String = ""
var current_phrase: String = ""
var current_letter = 0:
	set(val):
		current_letter = val
		if current_letter >= fields.size():
			current_letter = fields.size() - 1

var phrase: String = "":
	set(val):
		if val.length() < 25:
			phrase = val.to_lower()
			needed_phrase = phrase.replace(" ","")

			redraw_game_screen()
		else:
			push_error("Phtase can have a maximum of 25 letters.")
			return

var fields = []

var enemy_delay = 0
var last_enemy_appearance = 0

var cur_question = 0
var max_questions = 0
var time = 0

var fails = 0

var has_shown_answer = false
var is_muted = false

var tween: Tween = null
var annoucement_tween: Tween = null
var enemy_tween: Tween = null

var can_bully_spawn = true
var can_playtime_spawn = true

var detention_time = 0
var detention_counter = 0

var trash_cleaned = 0

var playtime_number = 1

var pomp_answer = 0
var pomp_answered = 0

func _ready():
	Globals.root.get_node("Menu").stop()
	$GameTheme.play()

	enemy_delay = randi_range(5,9)

	baldi_sound.stream = load(baldi_sounds["start"])
	baldi_sound.play()

	setup_game()
	update_items()
	next_question()

func _input(event):
	if event.is_action_pressed("cheat_answer") and game_state == GAME_STATES.READY:
		show_correct_answer()

	if event.is_action_pressed("cheat_remove_char") and enemy != ENEMIES.NONE:
		clear_enemy()

func setup_game():
	if Globals.cur_level_id == "Random":
		game_type = GAME_TYPES.RANDOM
		Globals.cur_level_id = logos.random_lessons.pick_random()
		max_questions = 20
	else:
		if Globals.cur_level_id.contains("Lesson"):
			game_type = GAME_TYPES.LESSON
		elif Globals.cur_level_id.contains("Test"):
			game_type = GAME_TYPES.TEST
		elif Globals.cur_level_id.contains("Exam"):
			game_type = GAME_TYPES.EXAM

		max_questions = logos.level_question_amount[Globals.cur_level_id]

	Globals.wrong_answered = 0
	Globals.correct_answered = 0
	Globals.bully_robberies = 0
	Globals.was_level_passed = false

	match game_type:
		1:
			game_title.text = "Lesson: " + str(Globals.level)
			time_text.hide()
		2:
			game_title.text = "Test: " + str(Globals.level)
			time_text.show()
			set_test_timer()
		3:
			game_title.text = "Exam: " + str(Globals.level)
			time_text.show()
			set_test_timer()
		4:
			game_title.text = "Random Test"
			time_text.show()
			set_test_timer()

func set_test_timer():
	if game_type == GAME_TYPES.RANDOM:
		time = 180
	else:
		time = logos.time_for_test[Globals.cur_level_id]

	time_text.text = "Time: " + str(time)
	test_timer.start()

func update_items():
	item_slot1.type = DataManager.items[0]
	item_slot2.type = DataManager.items[1]

func update_fails():
	if game_type == GAME_TYPES.LESSON:
		mistakes_text.text = "Wrong answers: " + str(fails) + "/2"
	else:
		mistakes_text.text = "Wrong answers: " + str(fails) + "/3"

func update_current():
	for i in range(fields.size()):
		if fields[i].letter_held == "":
			current_letter = i
			break
		elif i == fields.size() - 1:
			current_letter = fields.size() - 1

	game_state = GAME_STATES.READY

func choose_enemy():
	var num = randi_range(1,100)
	var chance = 20 * ((cur_question - last_enemy_appearance) - (enemy_delay - 1))

	if num >= chance:
		last_enemy_appearance = cur_question
		enemy_delay = randi_range(5,9)

		var enemy_num = randi_range(1,100)
		if enemy_num < 20 and can_bully_spawn:
			enemy = ENEMIES.BULLY
		elif enemy_num > 20 and enemy_num <= 40 and can_playtime_spawn:
			enemy = ENEMIES.PLAYTIME
		elif enemy_num > 40 and enemy_num <= 60:
			enemy = ENEMIES.PRINCIPAL
		elif enemy_num > 60 and enemy_num <= 80:
			enemy = ENEMIES.SWEEP
		else:
			enemy = ENEMIES.POMP

func check_for_enemy():
	if cur_question - last_enemy_appearance >= enemy_delay and enemy == ENEMIES.NONE and game_type != GAME_TYPES.LESSON:
		choose_enemy()

func next_question():
	has_shown_answer = false
	cur_question += 1

	if game_type == GAME_TYPES.LESSON:
		fails = 0
		update_fails()

	if cur_question == max_questions + 1:
		test_timer.stop()
		game_state = GAME_STATES.END
		Globals.was_level_passed = true
		goto_game_finish()
		return

	var logo = logos.get_random_logo(Globals.cur_level_id)

	if logo != "":
		phrase = logo
		logo_img.texture = load(logos.logo_paths[logo])

		amount_text.text = "Question " + str(cur_question) + "/" + str(max_questions)

	current_letter = 0
	correct.hide()
	wrong.hide()

	if tween != null:
		tween.kill()

	tween = get_tree().create_tween()
	tween.set_parallel()
	tween.tween_property(logo_img,"modulate:a",1,0.5)
	tween.tween_property(field_zone,"modulate:a",1,0.5)
	tween.tween_property(letter_zone,"modulate:a",1,0.5)

	await tween.finished

	tween.kill()

	var enemy_before = enemy

	check_for_enemy()

	if enemy != ENEMIES.NONE and (enemy_before != enemy):
		game_state = GAME_STATES.ENEMY
		show_enemy_message()
	else:
		game_state = GAME_STATES.READY

func show_enemy_message():
	$Sounds/Bell.play()

	match enemy:
		ENEMIES.BULLY:
			bully_sound.stream = load(bully_sounds["spawn"])
			bully_sound.play()

			enemy_title.text = "It's a Bully!"
			enemy_desc.text = "Give him one item or he'll steal your Quarters! Unless you want to wait for him to get bored."
		ENEMIES.PLAYTIME:
			playtime_sound.stream = load(playtime_sounds["laugh"])
			playtime_sound.play()

			enemy_title.text = "It's time for Playtime!"
			enemy_desc.text = "Count from 1 to 10! Don't mess up or you'll start again!"
		ENEMIES.PRINCIPAL:
			principal_sound.stream = load(principal_sounds["spawn"])
			principal_sound.play()

			enemy_title.text = "Oh no! The Principal!"
			enemy_desc.text = "Don't cheat now or he'll send you to Detention!"
		ENEMIES.SWEEP:
			sweep_sound.play()

			enemy_title.text = "It's time to Sweep!"
			enemy_desc.text = "The classroom is dirty! It's time to clean it!"
		ENEMIES.POMP:
			pomp_sound.stream = load(pomp_sounds["spawn"])
			pomp_sound.play()

			enemy_title.text = "Mrs Pomp is here!"
			enemy_desc.text = "Learn some math with Mrs Pomp!"

	if enemy_tween:
		enemy_tween.kill()

	enemy_tween = get_tree().create_tween()
	enemy_tween.tween_property(enemy_msg,"global_position:y",610,1).set_trans(Tween.TRANS_BOUNCE).from(-1080)
	enemy_tween.tween_callback(enemy_tween.kill)

func show_correct_answer():
	has_shown_answer = true
	game_state = GAME_STATES.CHEAT

	var cur_field = 0
	for letter in needed_phrase:
		var field = fields[cur_field]
		field.fast_update(letter)
		cur_field += 1

func question_correct():
	logo_img.modulate = Color.TRANSPARENT
	correct.show()

	$Sounds/Correct.play()

	if cur_question < max_questions:
		baldi_sound.stream = load(baldi_sounds["praise" + str(randi_range(1,4))])
		baldi_sound.play()

	if tween != null:
		tween.kill()

	tween = get_tree().create_tween()
	tween.set_parallel()

	tween.tween_property(field_zone,"modulate:a",0,0.5)
	tween.tween_property(letter_zone,"modulate:a",0,0.5)

	await tween.finished
	tween.kill()

	if not has_shown_answer:
		Globals.correct_answered += 1
	else:
		Globals.wrong_answered += 1

	await get_tree().create_timer(1)

	next_question()

func question_fail():
	fails += 1
	update_fails()

	logo_img.modulate = Color.TRANSPARENT
	wrong.show()

	$Sounds/Wrong.play()

	if fails > 3 and game_type != GAME_TYPES.LESSON:
		start_jumpscare()
		return

	if game_type == GAME_TYPES.LESSON:
		if fails == 2:
			baldi_sound.stream = load(baldi_sounds["help"])
			baldi_sound.play()
		else:
			baldi_sound.stream = load(baldi_sounds["again"])
			baldi_sound.play()
	else:
		baldi_sound.stream = load(baldi_sounds["fail"])
		baldi_sound.play()
		Globals.wrong_answered += 1

	await get_tree().create_timer(1).timeout

	wrong.hide()
	logo_img.modulate = Color.WHITE

	game_state = GAME_STATES.READY

	if game_type == GAME_TYPES.LESSON and fails == 2:
		show_correct_answer()
	elif game_type != GAME_TYPES.LESSON:
		next_question()

func reset_question():
	if game_state != GAME_STATES.READY:
		return

	current_letter = 0

	for field in fields:
		if field.letter_held == "" or field.btn == null:
			continue

		field.clear_letter()

	for button in letter_zone.get_children():
		button.show()

func clear_game_screen():
	for node in field_zone.get_children():
		node.free()

	for node in letter_zone.get_children():
		node.free()

func get_random_char() -> String:
	return char(randi_range(97,122))

func redraw_game_screen():
	await clear_game_screen()

	fields.clear()
	var letters = []
	for letter in needed_phrase:
		letters.append(letter)

	for letter in letters:
		var field = field_scene.instantiate()
		fields.append(field)
		field_zone.add_child(field)
		field.field_pressed.connect(_on_field_button_pressed)

	var trash_letters = clamp(30 - needed_phrase.length(),1,10)

	for x in range(trash_letters):
		letters.append(get_random_char())

	letters.shuffle()

	for letter in letters:
		var letter_button = letter_button_scene.instantiate()
		letter_zone.add_child(letter_button)
		letter_button.letter = letter
		letter_button.letter_pressed.connect(_on_letter_button_pressed)

func start_jumpscare():
	$CanvasLayer/UI/Pause.hide()
	$GameTheme.stop()

	$CanvasLayer/UI/Jumpscare.show()
	$End.play()

	await $End.finished

	goto_game_finish()

func goto_game_finish():
	game_state = GAME_STATES.END

	if Globals.was_level_passed:
		if game_type == GAME_TYPES.RANDOM:
			DataManager.has_failed_daily = false

		Composer.goto_scene_string("game_over",{
			"is_animated":true,
			"animation":1
		})
	else:
		Composer.goto_scene_string("game_over",{
			"is_animated":false,
			"animation":1
		})

func _on_submit_pressed():
	if game_state == GAME_STATES.ENEMY and enemy == ENEMIES.BULLY:
		bully_sound.stream = load(bully_sounds["cash"])
		bully_sound.play()
		clear_enemy()
		DataManager.coins -= 5
		animate_annoucement("Bully stole 5 Quarters from you!")
		Globals.bully_robberies += 1
		DataManager.save()
		return

	if game_state != GAME_STATES.READY \
	and game_state != GAME_STATES.CHEAT:
		$Fail.play()
		return

	game_state = GAME_STATES.GENERATING

	current_phrase = ""
	for field in fields:
		current_phrase += field.letter_held

	if current_phrase == needed_phrase:
		question_correct()
	else:
		question_fail()

func _on_field_button_pressed(field: FieldButton):
	if game_state != GAME_STATES.READY:
		$Fail.play()
		return

	if field.letter_held == "" or field.btn == null:
		return

	game_state = GAME_STATES.GENERATING

	field.clear_letter()
	update_current()

func _on_letter_button_pressed(btn: LetterButton):
	if game_state != GAME_STATES.READY:
		$Fail.play()
		return

	if current_letter == fields.size() - 1:
		var f = fields[current_letter]
		if f.letter_held != "":
			return

	game_state = GAME_STATES.GENERATING

	var letter = btn.letter
	var field = fields[current_letter]
	field.quiet_update(letter)
	current_letter += 1
	update_current()

	btn.modulate = Color.TRANSPARENT
	btn.disabled = true

	var fake_letter = fake_letter_scene.instantiate()
	fake_letters.add_child(fake_letter)
	fake_letter.global_position = btn.global_position

	fake_letter.letter = letter
	fake_letter.move_to(field.global_position)

	await fake_letter.finished

	field.update_letter(btn,letter)


func _on_field_zone_sort_children():
	var hs = field_zone.get("theme_override_constants/h_separation")
	var center = int(field_zone.size.x / 2)

	var rows = phrase.split(" ")
	var cur_child = 0
	var actual_child = 0
	var y_position = 0

	for word in rows:
		var total_size = (word.length() * 91) + (word.length() * (hs - 1))
		var begin_placement = (field_zone.size.x / 2) - (total_size / 2)

		for i in range(word.length()):
			var child = field_zone.get_child(actual_child)
			child.position = Vector2(begin_placement + (i * 91) + (i * hs),y_position)
			actual_child += 1

		y_position += 96

func _on_letter_zone_sort_children():
	if letter_zone.get_child_count() == 0:
		return

	var hs = letter_zone.get("theme_override_constants/h_separation")
	var center = int(letter_zone.size.x / 2)

	var rows = ceili(float(letter_zone.get_child_count()) / float(letter_zone.columns))
	var cur_child = 0
	var actual_child = 0

	for i in rows:
		cur_child = clamp((i+1) * letter_zone.columns,1,letter_zone.get_child_count())
		var cur_child_count = cur_child - i * letter_zone.columns

		var total_size = (cur_child_count * 91) + (cur_child_count * (hs - 1))
		var begin_placement = (letter_zone.size.x / 2) - (total_size / 2)

		for j in range(i * letter_zone.columns,cur_child):
			var child = letter_zone.get_child(j)
			child.position = Vector2(begin_placement + (actual_child * 91) + (actual_child * hs),child.position.y)
			actual_child += 1

		actual_child = 0

func _on_music_button_pressed():
	is_muted = !is_muted
	play_img.visible = !is_muted

	if is_muted:
		AudioServer.set_bus_volume_db(Globals.bus_indexes["master"],linear_to_db(0))
	else:
		AudioServer.set_bus_volume_db(Globals.bus_indexes["master"],linear_to_db(DataManager.settings["master_volume"]/100))

func _on_pause_pressed():
	button_click.play()
	get_tree().paused = true

	$CanvasLayer/UI/Pause.show()

func _on_resume_pressed():
	get_tree().paused = false
	button_click.play()

	$CanvasLayer/UI/Pause.hide()

func _on_menu_pressed():
	game_state = GAME_STATES.END
	$GameTheme.stop()
	get_tree().paused = false
	button_click.play()

	AudioServer.set_bus_volume_db(Globals.bus_indexes["master"],linear_to_db(DataManager.settings["master_volume"]/100))

	Composer.goto_scene_string("level_select",{
		"is_animated":true,
		"animation":1
	})

func _on_reset_button_button_down():
	$Reset.start()

func _on_reset_button_button_up():
	$Reset.stop()
	button_click.play()

	reset_question()

func _on_reset_timeout():
	if game_type == GAME_TYPES.RANDOM:
		return

	button_click.play()

	Composer.goto_scene_string("game",{
		"is_animated":true,
		"animation":1
	})

func _on_item_slot_slot_pressed(btn):
	if enemy == ENEMIES.SWEEP and btn.type != "Clock":
		return

	if btn.type == "None":
		if enemy == ENEMIES.BULLY:
			bully_sound.stream = load(bully_sounds["nopass"])
			bully_sound.play()
		return

	if game_type == GAME_TYPES.LESSON:
		$Fail.play()
		$FailReset.start()
		animate_annoucement("You cannot use items during lessons!")
		return

	if enemy == ENEMIES.BULLY && btn.type != "Bar":
		animate_annoucement("Bully stole your item!")
		bully_sound.stream = load(bully_sounds["item"])
		bully_sound.play()
		clear_enemy()
		btn.type = "None"
		DataManager.items[btn.slot] = "None"
		DataManager.save()
		return

	match btn.type:
		"Apple":
			if fails == 0:
				$Fail.play()
				return

			use_apple()
		"Clock":
			use_clock()
		"Keys":
			if enemy != ENEMIES.PRINCIPAL:
				$Fail.play()
				return

			use_keys()
		"Scissors":
			if enemy != ENEMIES.PLAYTIME:
				$Fail.play()
				return

			use_scissors()
		"Sheet":
			if game_state != GAME_STATES.READY:
				$Fail.play()
				return

			use_cheat()
		"Bar":
			if enemy != ENEMIES.BULLY:
				$Fail.play()
				return

			use_bar()

	btn.type = "None"
	DataManager.items[btn.slot] = "None"
	DataManager.save()

func animate_annoucement(text):
	annoucement_text.text = text
	annoucement_text.show()

	if annoucement_tween:
		annoucement_tween.kill()

	annoucement_text.modulate = Color.WHITE
	annoucement_tween = get_tree().create_tween()

	annoucement_tween.tween_property(annoucement_text,"position:y",-700,2).from(-115).set_trans(Tween.TRANS_SINE)
	annoucement_tween.parallel().tween_property(annoucement_text,"modulate:a",0,0.5).set_delay(1.5)

	annoucement_tween.tween_callback(
		func():
			annoucement_tween.kill()
			annoucement_text.hide()
			annoucement_text.modulate = Color.WHITE
			annoucement_text.position = Vector2(0,-115)
	)

func use_apple():
	baldi_sound.stream = load(baldi_sounds["apple"])
	baldi_sound.play()

	fails -= 1
	update_fails()

	animate_annoucement("+ 1 Extra Fail!")

func use_clock():
	time += 20
	time_text.text = "Time: " + str(time)

	animate_annoucement("+ Extra 20 seconds!")

func use_keys():
	clear_enemy()

	animate_annoucement("You have escaped the Detention!")

func use_scissors():
	can_playtime_spawn = false

	playtime_sound.stream = load(playtime_sounds["sad"])
	playtime_sound.play()
	clear_enemy()

	animate_annoucement("Playtime has left you!")

func use_cheat():
	if enemy == ENEMIES.PRINCIPAL:
		start_detention()
		return

	show_correct_answer()

	animate_annoucement("Cheat Used!")

func use_bar():
	can_bully_spawn = false
	bully_sound.stream = load(bully_sounds["cash"])
	bully_sound.play()
	clear_enemy()

	animate_annoucement("Now Bully won't bother you!")

func start_detention():
	game_state = GAME_STATES.DETENTION
	animate_annoucement("You got sent to the Detention!")
	$PrincipalTimer.stop()

	$CanvasLayer/UI/Game/Submit.hide()
	field_zone.hide()
	letter_zone.hide()

	detention_counter += 1
	match detention_counter:
		1:
			detention_time = 15
			principal_sound.stream = load(principal_sounds["15"])
		2:
			detention_time = 30
			principal_sound.stream = load(principal_sounds["30"])
		_:
			detention_time = 60
			principal_sound.stream = load(principal_sounds["60"])

	amount_text.text = "You have detention!"
	mistakes_text.text = str(detention_time) + " seconds remain!"
	$DetentionTimer.start()
	principal_sound.play()

func remove_detention():
	$CanvasLayer/UI/Game/Submit.show()
	field_zone.show()
	letter_zone.show()

	$DetentionTimer.stop()
	clear_enemy()

func spawn_enemy():
	match enemy:
		ENEMIES.BULLY:
			spawn_bully()
		ENEMIES.PLAYTIME:
			spawn_playtime()
		ENEMIES.PRINCIPAL:
			spawn_principal()
		ENEMIES.SWEEP:
			spawn_sweep()
		ENEMIES.POMP:
			spawn_pomp()

func clear_enemy():
	match enemy:
		ENEMIES.BULLY:
			remove_bully()
		ENEMIES.PLAYTIME:
			remove_playtime()
		ENEMIES.PRINCIPAL:
			remove_principal()
		ENEMIES.SWEEP:
			remove_sweep()
		ENEMIES.POMP:
			remove_pomp()

	enemy = ENEMIES.NONE
	game_state = GAME_STATES.READY

func spawn_bully():
	bully_img.show()
	bully_anim.play("bully")

	$BullyTimer.start()

	$CanvasLayer/UI/Game/Submit/Label.text = "GIVE CASH"

func remove_bully():
	bully_img.hide()
	bully_anim.stop()
	$BullyTimer.stop()

	$CanvasLayer/UI/Game/Submit/Label.text = "CHECK"

func spawn_principal():
	principal_img.show()
	principal_anim.play("principal")
	game_state = GAME_STATES.READY

	$PrincipalTimer.start()

func remove_principal():
	principal_img.hide()
	principal_anim.stop()
	$PrincipalTimer.stop()
	$DetentionTimer.stop()

	amount_text.text = "Question " + str(cur_question) + "/" + str(max_questions)
	update_fails()

func spawn_sweep():
	sweep_img.show()
	sweep_anim.play("sweep")

	amount_text.text = "Clean the screen!"

	spawn_trash()

func spawn_trash():
	trash_cleaned = 0

	$CanvasLayer/UI/Game/Submit.hide()
	field_zone.hide()
	letter_zone.hide()
	logo_img.hide()

	sweep_panel.show()

	var placement = []

	while placement.size() < 10:
		var num = randi_range(1,10)
		if not placement.has(num):
			placement.append(num)

	for i in range(placement.size()):
		var btn = sweep_panel.get_child(i)
		btn.reset()

		btn.global_position = Vector2(
			randf_range(1, 985),
			randf_range(1,100) + (192.0 * i)
		)

func _on_sweep_button_trash_pressed(btn):
	trash_cleaned += 1

	if trash_cleaned == 10:
		animate_annoucement("You've cleaned the class!")
		await get_tree().create_timer(2)
		clear_enemy()

func remove_sweep():
	sweep_panel.hide()
	sweep_img.hide()
	sweep_anim.stop()

	logo_img.show()
	$CanvasLayer/UI/Game/Submit.show()
	field_zone.show()
	letter_zone.show()

	amount_text.text = "Question " + str(cur_question) + "/" + str(max_questions)

func spawn_playtime():
	playtime_img.show()
	playtime_anim.play("playtime")

	playtime_sound.stream = load(playtime_sounds["spawn"])
	playtime_sound.play()

	amount_text.text = "Count from 1 to 10!"

	spawn_numbers()

func spawn_numbers():
	playtime_number = 1

	$CanvasLayer/UI/Game/Submit.hide()
	field_zone.hide()
	letter_zone.hide()
	logo_img.hide()

	playtime_panel.show()

	var placement = []

	while placement.size() < 10:
		var num = randi_range(1,10)
		if not placement.has(num):
			placement.append(num)

	for i in range(placement.size()):
		var btn = playtime_panel.get_child(i)
		btn.reset()

		btn.global_position = Vector2(
			randf_range(1, 15) + (99.0 * i),
			randf_range(1175,1820)
		)

func _on_playtime_button_playtime_pressed(btn):
	if btn.num == playtime_number:
		btn.correct()

		playtime_sound.stream = load("res://assets/sounds/" + str(playtime_number) + ".mp3")
		playtime_sound.play()

		playtime_number += 1
		if playtime_number == 11:
			playtime_sound.stream = load(playtime_sounds["congrats"])
			playtime_sound.play()
			await get_tree().create_timer(1).timeout
			clear_enemy()
			return
	else:
		animate_annoucement("You messed up! Try again!")
		playtime_sound.stream = load(playtime_sounds["oops"])
		playtime_sound.play()
		spawn_numbers()

func remove_playtime():
	playtime_img.hide()
	playtime_anim.stop()

	$CanvasLayer/UI/Game/Submit.show()
	field_zone.show()
	letter_zone.show()
	logo_img.show()

	playtime_panel.hide()

	amount_text.text = "Question " + str(cur_question) + "/" + str(max_questions)

func spawn_pomp():
	pomp_answered = 0

	pomp_img.show()
	pomp_anim.play("pomp")
	pomp_panel.show()

	amount_text.text = "Solve the math problems!"

	$CanvasLayer/UI/Game/Submit.hide()
	field_zone.hide()
	letter_zone.hide()
	logo_img.hide()

	next_pomp_question()

func next_pomp_question():
	var num1 = randi_range(1,9)
	var num2 = randi_range(1,9)

	pomp_answer = num1 + num2

	var answers = [pomp_answer]
	while answers.size() < 4:
		var num = randi_range(10,20)
		if not answers.has(num):
			answers.append(num)

	answers.shuffle()

	for i in range(answers.size()):
		var button = pomp_panel.get_node("HBoxContainer").get_child(i)
		button.num = answers[i]
		button.reset()

	amount_text.text = "Solve: " + str(num1) + " + " + str(num2)

	pomp_sound.stream = load("res://assets/sounds/pomp_" + str(num1) + ".mp3")
	pomp_sound.play()

	await pomp_sound.finished

	pomp_sound.stream = load(pomp_sounds["add"])
	pomp_sound.play()

	await pomp_sound.finished

	pomp_sound.stream = load("res://assets/sounds/pomp_" + str(num2) + ".mp3")
	pomp_sound.play()

	await pomp_sound.finished

func _on_pomp_button_pressed(btn):
	if btn.num == pomp_answer:
		pomp_answered += 1
		if pomp_answered == 3:
			pomp_sound.stream = load(pomp_sounds["end"])
			pomp_sound.play()

			animate_annoucement("Mrs Pomp is very proud of you!")

			clear_enemy()
			return

		animate_annoucement("Correct!")

		pomp_sound.stream = load(pomp_sounds["correct"])
		pomp_sound.play()

		next_pomp_question()
	else:
		animate_annoucement("Uh oh...")

		pomp_anim.stop()
		angry_pomp.show()
		pomp_sound.stream = load(pomp_sounds["wrong"])
		pomp_sound.play()

		await pomp_sound.finished
		clear_enemy()

func remove_pomp():
	pomp_img.hide()
	pomp_anim.stop()
	pomp_panel.hide()
	angry_pomp.hide()

	$CanvasLayer/UI/Game/Submit.show()
	field_zone.show()
	letter_zone.show()
	logo_img.show()

	amount_text.text = "Question " + str(cur_question) + "/" + str(max_questions)

func _on_fail_reset_timeout():
	update_fails()

func _on_test_timeout():
	time -= 1
	time_text.text = "Time: " + str(time)

	if time == 30:
		var playback_pos = $GameTheme.get_playback_position()
		$GameTheme.stop()
		$GameTheme2.seek(playback_pos)
		$GameTheme2.play()

	if time == -1:
		test_timer.stop()

		if game_state != GAME_STATES.END:
			game_state = GAME_STATES.END
			start_jumpscare()

func _on_ok_pressed():
	if enemy_tween and enemy_tween.is_running():
		return

	enemy_tween.kill()
	enemy_tween = get_tree().create_tween()
	enemy_tween.tween_property(enemy_msg,"global_position:y",-1080,1).set_trans(Tween.TRANS_BOUNCE)
	enemy_tween.tween_callback(
		func():
			spawn_enemy()
			enemy_tween.kill()
	)


func _on_bully_timer_timeout():
	bully_sound.stream = load(bully_sounds["bored"])
	bully_sound.play()
	clear_enemy()


func _on_detention_timer_timeout():
	detention_time -= 1
	mistakes_text.text = "Detention Time Left: " + str(detention_time)
	if detention_time == 0:
		animate_annoucement("Detention is over!")
		clear_enemy()

func _on_principal_timer_timeout():
	animate_annoucement("Principal is gone!")
	clear_enemy()
