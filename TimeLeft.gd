extends Label

func _process(_delta):
    self.text = "Time Left: %d" % $"../Timer".time_left
