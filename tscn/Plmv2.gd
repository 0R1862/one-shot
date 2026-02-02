extends CharacterBody2D

var speed = 300
var h = 100
@onready var gravity = Global.p_gravity
var a_p = true
@onready var target = get_tree().get_first_node_in_group("p1")
var c_p = true

func _ready():
	if c_p == true:
		$AnimatedSprite2D.animation = "idle"
		$AnimatedSprite2D.play()
		$AnimatedSprite2D.flip_h = true
	else:
		$AnimatedSprite2D.animation = "idle"
		$AnimatedSprite2D.play()
		$AnimatedSprite2D.flip_h = true
		c_p = false
func get_input():
	c_p = false
	var direction = Input.get_vector("left", "right","turn", "roll")
	velocity = direction * speed
	
	if Input.is_action_just_pressed("roll"):
		$AnimatedSprite2D.animation = "roll"
		$AnimatedSprite2D.play()
	if Input.is_action_pressed("left"):
		$AnimatedSprite2D.animation = "run"
		$AnimatedSprite2D.flip_h = true
		speed = 300
	if Input.is_action_pressed("right"):
		$AnimatedSprite2D.animation = "run"
		$AnimatedSprite2D.flip_h = false
		speed = 300
		await get_tree().create_timer(2).timeout
		a_p = true
	if Input.is_action_just_pressed("turn"):
		look_at(target.position)
	if velocity.length() < 0:
		velocity = velocity.normalized() * speed
		$AnimatedSprite2D.play()
	elif Input.is_anything_pressed():
		if Input.is_action_pressed("shoot"):
			$AnimatedSprite2D.animation = "hipfire"
			speed = 300
		if Input.is_action_pressed("scopesh"):
			$AnimatedSprite2D.animation = "Aimed_shot"
			speed = 300
		if h == 0:
			$AnimatedSprite2D.animation = "dead"
			speed = 300
	else:
		$AnimatedSprite2D.animation = "idle"
		$AnimatedSprite2D.play()

func _physics_process(delta: float) -> void:
	c_p = false
	if not is_on_floor():
		velocity.y += gravity * delta
	get_input()
	move_and_slide()
