extends Area

func _physics_process(delta):
	self.rotate(Vector3.ONE.normalized(), deg2rad(45) * delta)

func _on_Pickup_body_entered(body):
	if !$"../../Timer".is_stopped():
		if body.is_in_group("Ball"):
			$"../../Score".increment_score()
			self.queue_free()
