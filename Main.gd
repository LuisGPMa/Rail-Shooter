extends Node2D

var total : float = 0
const SPEED : int = 100

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	update_score(total)
	
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_right"):
		print("Right arrow")

func _physics_process(delta: float) -> void:
	if Input.is_action_pressed("ui_right"):
		print("Move right")
		position.x += SPEED * delta	

#func _process(delta: float) -> void:
#	total += delta
#	update_score(total)
#	pass
	
func update_score(current_score: float) -> void:
	$Score.text = "Score: " + str(total)


func _on_ScoreTimer_timeout() -> void:
	total += 1
	update_score(total)
