extends CharacterBody2D

var speed = 200
var h = 100

func get_input():
	if Input.is_action_pressed("shoot"):
		$AnimatedSprite2D.animation = "hipfire"
	if Input.is_action_pressed("scopesh"):
		$AnimatedSprite2D.animation = "Aimed_shot"
	if h <= 0:
		$AnimatedSprite2D.animation = "dead"
