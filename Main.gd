extends Node2D

var total : float = 0
const SPEED : int = 100

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass
	
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_right"):
		print("Right arrow")



#func _process(delta: float) -> void:
#	total += delta
#	update_score(total)
#	pass
