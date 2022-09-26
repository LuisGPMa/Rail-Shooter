extends Area2D

func _ready() -> void:
	var tween = get_tree().create_tween().set_trans(Tween.TRANS_ELASTIC).set_ease(Tween.EASE_IN_OUT)
	tween.tween_property(self, "scale", Vector2(1.5,1.5), 0.4)
	tween.tween_property(self, "scale", Vector2(1,1), 0.4)
	tween.tween_callback(self, "inicio")
	
	#$AnimationPlayer.play("appear")
	
func _on_VisibilityNotifier2D_screen_exited() -> void:
	queue_free()

func inicio():
	print("Fim da animação")
