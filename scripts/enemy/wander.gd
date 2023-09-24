extends EnemyState

# declares a vector that holds the current destination of the enemy
var destination = Vector2.ZERO


func enter(_msg := {}) -> void:
	# change all random functions' seed
	randomize()


func physics_update(_delta: float) -> void:
	# check if the enemy has spotted the player via the boolean
	if enemy.player_spotted:
		# enter the chase state
		state_machine.transition_to("Chase")
	
	# check if the enemy has made it to the random destination
	if enemy.wander_completed(destination):
		# pick a new destination to go to
		destination = Vector2(randf_range(-1920, 3840), randf_range(-1080, 2160))
	
	# move the enemy to the random point
	enemy.wander(destination)
	# set the debug label
	enemy.get_node("DebugLabel").text = str(name)
