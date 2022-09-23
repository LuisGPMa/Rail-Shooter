extends CanvasLayer

onready var score := 0

func updateScore():
	score += 1
	$ScoreLabel.text = "Score: " + str(score)
		

