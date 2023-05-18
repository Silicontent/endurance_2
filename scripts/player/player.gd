# dash code from old project, gotten from:
# https://www.reddit.com/r/godot/comments/r7rui0/comment/hn1s4qr/?utm_source=share&utm_medium=web2x&context=3

class_name Player
extends CharacterBody2D

signal player_dead

const BASE_SPEED := 1000.0
const MAX_ADDITION := 1500.0
var speed_addition := 0.0
var total_speed := 0.0

var invulnerable := false
var can_dash := false
var dead := false

@onready var cooldown_timer = $Cooldown
@onready var dash_timer = $DashTimer
@onready var state_display = $StateDisplay
#@onready var cooldown_bar = $DashHUD/CooldownBar
@onready var cooldown_text = $CooldownDisplay


func move():
	velocity = Vector2.ZERO
	
	if Input.is_action_pressed("mv_up"):
		velocity.y -= 1
	if Input.is_action_pressed("mv_down"):
		velocity.y += 1
	if Input.is_action_pressed("mv_left"):
		velocity.x -= 1
	if Input.is_action_pressed("mv_right"):
		velocity.x += 1
	
	velocity = velocity.normalized() * total_speed
	move_and_slide()
	
	# clamp the player's position on the map
	position.x = clamp(position.x, -1920.0, 3840.0)
	position.y = clamp(position.y, -1080.0, 2160.0)


func die() -> void:
	emit_signal("player_dead")
	cooldown_timer.stop()


func _ready() -> void:
	invulnerable = false
	dead = false


func _physics_process(_delta: float) -> void:
	total_speed = BASE_SPEED + speed_addition


func _on_killbox_body_entered(body):
	if invulnerable:
		body.die()
	else:
		dead = true
