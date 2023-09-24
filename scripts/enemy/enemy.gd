# the base class that all enemies have, contains parameters that
# the states in each enemy can use

class_name Enemy
extends CharacterBody2D

# movement speed of the enemy
@export var speed := 500
# how many points the player earns by killing the enemy
@export var score_reward := 1

# reference to the player
var player: Player
# reference to the enemy manager the enemy belongs to
var manager = null
# controls whether or not the enemy is invincible
var invulnerable = false
# changed if the player enters the enemy's vision
var player_spotted = false

# reference to the persistance timer (enemy keeps following the player even after the player leaves vision)
@onready var persist_timer = $PersistTimer
# reference to the timer that gives the enemy a spawning-in window
@onready var spawn_timer = $SpawnTimer


# DEFINED FUNCTIONS ======================================================
# moves the enemy towards a specified position
func move_towards_pos(location: Vector2, speed_multi: float) -> void:
	# sets the velocity towards the location and multiplies the enemy's speed
	# by the specified multiplier
	velocity = (location - position).normalized() * (speed * speed_multi)
	# moves the enemy based on the velocity
	move_and_slide()


# moves the enemy towards the player's position
func chase_player() -> void:
	move_towards_pos(player.position, 1.0)


# moves the enemy towards the randomly chosen destination
func wander(destination: Vector2) -> void:
	move_towards_pos(destination, 0.5)


# checks if the enemy is close to the destination set in the wandering state
func wander_completed(destination: Vector2) -> bool:
	# returns T/F with a margin of 10 pixels
	return (destination - global_position).length() < 10.0


# what to do when the enemy dies
func die() -> void:
	# tell the enemy's manager to emit a signal saying that an enemy has died
	# pass along the amount of score the player should receive
	manager.emit_signal("killed", score_reward)
	# remove the enemy from the scene tree
	queue_free()


# SIGNAlS ================================================================
# triggered when a body enters the enemy's vision
func _on_vision_area_body_entered(body):
	# check if the body is the player
	if body.is_class("Player"):
		# stop the persistance timer (begins again once the body leaves)
		persist_timer.stop()
		# the player has been spotted
		player_spotted = true


# triggered when a body leaves the enemy's vision
func _on_vision_area_body_exited(body):
	# checks of the body is the player and if the player has already been spotted
	if body.is_class("Player") and player_spotted:
		# begin the persistance timer
		persist_timer.start()


# triggered when the persistance timer runs out
func _on_persist_timer_timeout():
	# consider the player no longer spotted
	player_spotted = false
