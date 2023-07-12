extends LetterButton

signal finished

var movement_tween: Tween

func move_to(pos: Vector2):
	if movement_tween:
		movement_tween.kill()

	movement_tween = get_tree().create_tween()
	movement_tween.tween_property(self,"global_position",pos,0.5).set_trans(Tween.TRANS_QUART)
	movement_tween.tween_callback(
		func():
			finished.emit()
			queue_free()
	)
