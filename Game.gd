extends Spatial

func _input(event):
	if event.is_action_pressed("ui_cancel"):
		self.get_tree().quit()
