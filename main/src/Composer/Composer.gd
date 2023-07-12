extends Node

var scene_paths: Dictionary = {
	"main_menu":"res://src/MainMenu/MainMenu.tscn",
	"level_select":"res://src/LevelSelect/LevelSelect.tscn",
	"game":"res://src/Game/Game.tscn",
	"game_over":"res://src/GameOver/GameOver.tscn",
	"store":"res://src/Store/Store.tscn",
	"settings":"res://src/Settings/Settings.tscn",
	"credits":"res://src/Credits/Credits.tscn",
}

var current_scene: Node2D = null;

enum ANIMATIONS {
	NONE=0,
	FADE=1,
}

var _variables: Dictionary = {}

var _is_entering_scene: bool = false
var _root: Node2D = null

var _scene_path: String = ""
var _packed_scene: PackedScene = null
var _current_args: Dictionary = {}
var _current_scene_vars: Dictionary = {}

func get_scene_variables() -> Dictionary:
	return _variables

func get_scene_name() -> String:
	if current_scene == null:
		return ""

	return current_scene.name

func reload_current_scene():
	if current_scene == null:
		return

	if _scene_path != "":
		goto_scene_string(_scene_path,_current_args,_current_scene_vars)
	elif _packed_scene != null:
		goto_scene_packed(_packed_scene,_current_args,_current_scene_vars)

func remove_scene(scene: String):
	var _scene_to_remove = _root.get_node_or_null(scene)

	if _scene_to_remove == null:
		return

	_scene_to_remove.queue_free()

func remove_current_scene():
	if current_scene == null:
		return

	_root.get_node(str(current_scene.name)).queue_free()
	current_scene = null

func goto_scene_string(scene: String, args: Dictionary = {}, vars: Dictionary = {}):
	if _is_entering_scene:
		return

	_is_entering_scene = true

	if not scene.contains("res://"):
		if scene_paths.has(scene):
			_scene_path = scene_paths[scene]
		else:
			push_error("Invalid scene name. Have you made a typo?")
			return
	else:
		_scene_path = scene

	if _root == null:
		_root = get_tree().root.get_node("Main")

	_variables = vars
	_current_args = args
	_current_scene_vars = _variables

	call_deferred("_deferred_goto_scene_string",_scene_path,args)

func goto_scene_packed(scene: PackedScene, args: Dictionary, vars: Dictionary):
	if _is_entering_scene:
		return

	_is_entering_scene = true

	if _root == null:
		_root = get_tree().root.get_node("Main")

	_variables = vars

	_packed_scene = scene
	_current_args = args
	_current_scene_vars = _variables

	call_deferred("_deferred_goto_scene",_scene_path,args)

func _deferred_goto_scene_string(scene: String, args: Dictionary = {}):
	var _is_animated: bool = args["is_animated"] if args.has("is_animated") else false
	var _animation: ANIMATIONS = args["animation"] if args.has("animation") else ANIMATIONS.NONE

	if _is_animated and _animation != ANIMATIONS.NONE:
		match _animation:
			ANIMATIONS.FADE:
				fade_transition_string(scene,args)
				return

	_add_scene_string(scene)

	_is_entering_scene = false

func _deferred_goto_scene_packed(scene: PackedScene, args: Dictionary = {}):
	var _is_animated: bool = args["is_animated"] if args.has("is_animated") else false
	var _animation: ANIMATIONS = args["animation"] if args.has("animation") else ANIMATIONS.NONE

	if _is_animated and _animation != ANIMATIONS.NONE:
		match _animation:
			ANIMATIONS.FADE:
				fade_transition_packed(scene,args)
				return

	_add_scene_packed(scene)

	_is_entering_scene = false

func fade_transition_string(scene: String, args: Dictionary):
	var _control: Control = _root.get_node("CanvasLayer/TransitionUI")
	_control.show()

	var _transition_rect: ColorRect = _control.get_node("FadeRect")
	_transition_rect.show()

	if current_scene != null:
		var _fade_in_tween: Tween = get_tree().create_tween()
		var _fade_in_duration: float = args["fade_in_duration"] if args.has("fade_in_duration") else 0.5

		_transition_rect.color = Color(0,0,0,0)

		_fade_in_tween.tween_property(_transition_rect,"color",Color(0,0,0,1),_fade_in_duration).set_trans(Tween.TRANS_SINE)

		await _fade_in_tween.finished

		_fade_in_tween.kill()

	_add_scene_string(scene)

	var _fade_out_tween: Tween = get_tree().create_tween()
	var _fade_out_duration: float = args["fade_out_duration"] if args.has("fade_out_duration") else 0.5

	_fade_out_tween.tween_property(_transition_rect,"color",Color(0,0,0,0),_fade_out_duration).set_trans(Tween.TRANS_SINE)

	await _fade_out_tween.finished

	_is_entering_scene = false

	_fade_out_tween.kill()
	_transition_rect.hide()
	_control.hide()

func fade_transition_packed(scene: PackedScene, args: Dictionary):
	var _control: Control = _root.get_node("CanvasLayer/TransitionUI")
	_control.show()

	var _transition_rect: ColorRect = _control.get_node("FadeRect")
	_transition_rect.show()

	if current_scene != null:
		var _fade_in_tween: Tween = get_tree().create_tween()
		var _fade_in_duration: float = args["fade_in_duration"] if args.has("fade_in_duration") else 0.5

		_transition_rect.color = Color(0,0,0,0)

		_fade_in_tween.tween_property(_transition_rect,"color",Color(0,0,0,1),_fade_in_duration).set_trans(Tween.TRANS_SINE)

		await _fade_in_tween.finished

		_fade_in_tween.kill()

	_add_scene_packed(scene)

	var _fade_out_tween: Tween = get_tree().create_tween()
	var _fade_out_duration: float = args["fade_out_duration"] if args.has("fade_out_duration") else 0.5

	_fade_out_tween.tween_property(_transition_rect,"color",Color(0,0,0,0),_fade_out_duration).set_trans(Tween.TRANS_SINE)

	await _fade_out_tween.finished

	_is_entering_scene = false

	_fade_out_tween.kill()
	_transition_rect.hide()
	_control.hide()

func _add_scene_string(scene: String):
	if current_scene != null:
		_root.get_node(str(current_scene.name)).queue_free()

	_root.add_child(load(scene).instantiate(),true)

	current_scene = _root.get_child(_root.get_child_count() - 1)

func _add_scene_packed(scene: PackedScene):
	if current_scene != null:
		_root.get_node(str(current_scene.name)).queue_free()

	_root.add_child(scene.instantiate(),true)

	current_scene = _root.get_child(_root.get_child_count() - 1)
