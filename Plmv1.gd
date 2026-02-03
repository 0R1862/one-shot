extends CharacterBody2D

var bullet_path=preload("res://tscn/bullet.tscn")
var speed = 300
var h = 100
@onready var gravity = Global.p_gravity
var a_p = true
@onready var target = get_tree().get_first_node_in_group("p2")
var max_ammo := 1
var ammo := 1
var reload_time := 1.8
var is_rld = false
var c_p = true
var m_p = get_global_mouse_position().y

func reload():
	if is_rld:
		return
	
	is_rld = true
	
	await get_tree().create_timer(reload_time).timeout
	
	ammo = max_ammo
	is_rld = false
func _ready():
	if c_p == true:
		$AnimatedSprite2D.animation = "idle"
		$AnimatedSprite2D.play()
		$AnimatedSprite2D.flip_h = false
	else:
		$AnimatedSprite2D.animation = "idle"
		$AnimatedSprite2D.play()
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
	if velocity.length() < 0:
		velocity = velocity.normalized() * speed
		$AnimatedSprite2D.play()
	elif Input.is_anything_pressed():
		if Input.is_action_just_pressed("shoot"):
			$AnimatedSprite2D.animation = "hipfire"
			if is_rld == true:
				reload()
			else:
				$AnimatedSprite2D.play("hipfire")
			speed = 300
		if Input.is_action_just_pressed("scopesh"):
			$AnimatedSprite2D.animation = "Aimed_shot"
			if is_rld == true:
				reload()
			else:
				$AnimatedSprite2D.play("Aimed_shot")
			speed = 300
		if h == 0:
			$AnimatedSprite2D.animation = "dead"
			speed = 300
	else:
		$AnimatedSprite2D.animation = "idle"
		$AnimatedSprite2D.play()

func _physics_process(_delta: float) -> void:
	if m_p > 0:
		look_at(get_global_mouse_position())
	$AnimatedSprite2D.flip_h = false
	if Input.is_action_just_pressed("shoot") or Input.is_action_just_pressed("scopesh") and is_rld == false:
		fire()
		reload()
	elif Input.is_action_just_pressed("shoot") or Input.is_action_just_pressed("scopesh") and is_rld== true:
		$AnimatedSprite2D.stop()
	get_input()
	move_and_slide()

func fire():
	if is_rld == true:
		if $AnimatedSprite2D.animation == "hipfire" or $AnimatedSprite2D.animation == "scopesh":
			$AnimatedSprite2D.stop()
		reload()
	else:
		var bullet=bullet_path.instantiate()
		bullet.dir=rotation
		bullet.pos=$AnimatedSprite2D.global_position
		bullet.rota=global_rotation
		get_parent().add_child(bullet)
