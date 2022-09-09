extends Node2D

var total : float = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	update_score(total)
	
func _process(delta: float) -> void:
	total += delta
	update_score(total)
	
func update_score(current_score: float) -> void:
	$Score.text = "Score: " + str(total)
