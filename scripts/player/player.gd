# dash code from old project, gotten from:
# https://www.reddit.com/r/godot/comments/r7rui0/comment/hn1s4qr/?utm_source=share&utm_medium=web2x&context=3

class_name Player
extends CharacterBody2D

# emits when the player dies
signal player_dead

# the minimum speed the player goes
const BASE_SPEED := 1000.0
# the maximum speed the player goes
const MAX_ADDITION := 1500.0
# how much speed is being added to the total speed
var speed_addition := 0.0
# speed actually multiplied with velocity
var total_speed := 0.0

# toggled to signify when the player is invincible
var invulnerable := false
# toggled to signify when the player can use their dash
var can_dash := false
# toggled to signify that the player is dead
var dead := false

# gets references to child nodes as needed
@onready var cooldown_timer = $Cooldown
@onready var dash_timer = $DashTimer
@onready var state_display = $StateDisplay
#@onready var cooldown_bar = $DashHUD/CooldownBar
@onready var cooldown_text = $CooldownDisplay


# DEFINED FUNCTIONS ======================================================
# lets the user move the player around
func move():
	# resets the velocity to zero
	velocity = Vector2.ZERO
	
	# checks which direction the player is going
	if Input.is_action_pressed("mv_up"):
		velocity.y -= 1
	if Input.is_action_pressed("mv_down"):
		velocity.y += 1
	if Input.is_action_pressed("mv_left"):
		velocity.x -= 1
	if Input.is_action_pressed("mv_right"):
		velocity.x += 1
	
	# prevents diagonal movement from being faster than normal movement
	velocity = velocity.normalized() * total_speed
	# moves the player
	move_and_slide()
	
	# clamp the player's position on the map
	position.x = clamp(position.x, -1920.0, 3840.0)
	position.y = clamp(position.y, -1080.0, 2160.0)


# triggered when the player dies
func die() -> void:
	emit_signal("player_dead")
	cooldown_timer.stop()


# RUNNING FUNCTIONS ======================================================
# starting conditions for the player
func _ready() -> void:
	invulnerable = false
	dead = false


func _physics_process(_delta: float) -> void:
	# continuously add to the base speed
	total_speed = BASE_SPEED + speed_addition


func _on_killbox_body_entered(body):
	pass
#	if invulnerable:
#		body.die()
#	else:
#		dead = true


# SIGNALS ================================================================
# triggered when the player's Hitbox enters a body
func _on_hitbox_body_entered(body):
	if invulnerable:
		# kill the body entered
		body.die()
	else:
		# kill the player
		dead = true
