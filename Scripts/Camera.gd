extends Camera

var ballOffset = self.transform.origin

func _process(_delta):
    self.global_transform.origin = $"../Ball".global_transform.origin + self.ballOffset
