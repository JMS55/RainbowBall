extends Label

var score = 0

func increment_score():
    self.score += 1
    self.text = "Score: %d" % self.score
