extends KinematicBody2D

export (int) var speed = 300
export (float) var rotation_speed = 1.5
export (int) var jump_speed = 1000
export (int) var gravity = 2500

export (PackedScene) var box : PackedScene

var velocity := Vector2.ZERO
var rotation_dir := 0

# Onready inicializa como se estivesse no callback _ready
onready var target = position
onready var sprite := $Sprite
onready var audioPlayer := $AudioPlayer

#onready var box := preload("res://Items/Box.tscn")


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.
	
func _input(event):
	if event.is_action_pressed("click"):
		target = get_global_mouse_position()

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
		
func get_side_input():
	velocity.x = 0
	var right = Input.is_action_pressed('right')
	var left = Input.is_action_pressed('left')

	if is_on_floor() and Input.is_action_just_pressed("jump"):
		velocity.y = -jump_speed
		# Aumenta em 1 o score ao saltar
		get_tree().call_group("HUD", "updateScore")
		# Cria uma caixa ao saltar
		var b := box.instance()
		owner.add_child(b)
		b.position = global_position
		# Toca o som de pulo
		audioPlayer.play()
		
	if right:
		velocity.x += speed
	if left:
		velocity.x -= speed
	if velocity.x > 0:
		sprite.play("right")
	elif velocity.x < 0:
		sprite.play("left")
	else:
		sprite.stop()
		sprite.frame = 0
	#print(velocity)
	
	
func _physics_process(delta):
	# 1. Movimento em 8 direções
	#get_8way_input()
	
	# 2. Rotação e movimento com teclado	
	#get_rotation_input()
	#rotation += rotation_dir * rotation_speed * delta	
	
	# 3. Rotação com mouse + movimento com teclado
	#get_mouse_input()	
	
	# 4. Point and click
	#get_point_and_click()
	
	# look_at(target)
	
	# 5. Movimento lateral com salto + gravidade
	velocity.y += gravity * delta
	get_side_input()
	velocity = move_and_slide(velocity, Vector2.UP)
