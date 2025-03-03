extends Node2D

var sceneLimit : Position2D
var player : KinematicBody2D
var musicPlayer : AudioStreamPlayer2D

var currentScene = null

func _ready() -> void:
	currentScene = get_child(0)
	sceneLimit = currentScene.get_node("SceneLimit")
	player = currentScene.get_node("Player")
	musicPlayer = $MusicPlayer
	var effect : AudioEffectLowPassFilter = AudioServer.get_bus_effect(1, 0)
	print(effect)
	effect.cutoff_hz = 500

func _physics_process(delta: float) -> void:
	if sceneLimit == null:
		return
		
	if player.position.y > sceneLimit.position.y:
		get_tree().change_scene("res://GameOver.tscn")

	if Input.is_key_pressed(KEY_X):
		musicPlayer.stop()
		call_deferred("goto_scene", "res://GameOver.tscn")		

func goto_scene(path: String):
	print("Total children: "+str(get_child_count()))
	var world := get_child(0)
	world.free()
	var res := ResourceLoader.load(path)
	currentScene = res.instance()
	sceneLimit = null
	get_tree().get_root().add_child(currentScene)
	
