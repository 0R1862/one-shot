extends CharacterBody2D

var pos: Vector2
var dir: float
var rota: float
var speed = 2000

func _ready():
	global_position=pos
	global_rotation=rota
func _physics_process(_delta):
	velocity=Vector2(speed, 0).rotated(dir)
	rotate(90.0)
	move_and_slide()
