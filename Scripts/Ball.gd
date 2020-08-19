extends RigidBody

func _physics_process(delta):
    if !$"../Timer".is_stopped():
        var force = Vector3.ZERO
        if Input.is_action_pressed("ball_forward"):
            force += Vector3.FORWARD
        if Input.is_action_pressed("ball_back"):
            force += Vector3.BACK
        if Input.is_action_pressed("ball_right"):
            force += Vector3.RIGHT
        if Input.is_action_pressed("ball_left"):
            force += Vector3.LEFT
        force = force.normalized() * 15.0 * (delta * 60.0)
        self.add_force(force, Vector3.ZERO)
