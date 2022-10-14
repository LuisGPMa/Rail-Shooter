extends KinematicBody2D

export (int) var speed = 25
export (float) var rotation_speed = 1.5

export (PackedScene) var box : PackedScene

var velocity := Vector2.ZERO
var rotation_dir := 0

# Onready inicializa como se estivesse no callback _ready
onready var path_follow = get_parent()
onready var target = position
onready var sprite := $Sprite
#onready var audioPlayer := $AudioPlayer

#onready var box := preload("res://Items/Box.tscn")

func MovementLoop(delta):
	var prepos = path_follow.get_global_position()
	path_follow.set_offset(path_follow.get_offset() + speed*delta)
	var pos = path_follow.get_global_position()
	rotation_dir = (pos.angle_to_point(prepos) / 3.14)*180
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.
	
func _input(event):
	if event.is_action_pressed("click"):
		target = get_global_mouse_position()
		
func shoot():
	pass

func get_8way_input():
	velocity = Vector2.ZERO
	velocity.x = Input.get_action_strength("right") - Input.get_action_strength("left")
	velocity.y = Input.get_action_strength("down") - Input.get_action_strength("up")	
	if velocity.x > 0:
		sprite.play("right")
	elif velocity.x < 0:
		sprite.play("left")
	elif velocity.y > 0:
		sprite.play("down")
	elif velocity.y < 0:
		sprite.play("up")
	else:
		sprite.stop()
		sprite.frame = 0
	velocity = velocity.normalized() * speed
	#print(velocity)

func get_rotation_input():
	rotation_dir = 0
	velocity = Vector2.ZERO
	if Input.is_action_pressed("right"):
		rotation_dir += 1
	if Input.is_action_pressed("left"):
		rotation_dir -= 1
	if Input.is_action_pressed("down"):
		velocity = Vector2(-speed, 0).rotated(rotation)
	if Input.is_action_pressed("up"):
		velocity = Vector2(speed, 0).rotated(rotation)

func get_mouse_input():
	look_at(get_global_mouse_position())
	velocity = Vector2()
	if Input.is_action_pressed("down"):
		velocity = Vector2(-speed, 0).rotated(rotation)
	if Input.is_action_pressed("up"):
		velocity = Vector2(speed, 0).rotated(rotation)

func get_point_and_click():
	velocity = position.direction_to(target) * speed
	if position.distance_to(target) <= 5:
		velocity = Vector2.ZERO

func _physics_process(delta: float) -> void:
	MovementLoop(delta)
