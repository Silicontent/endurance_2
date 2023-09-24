extends EnemyState


func physics_update(_delta: float) -> void:
	# set the debug text with the persistance time left
	enemy.get_node("DebugLabel").text = "Chase: " + str(enemy.persist_timer.time_left)
	
	# move the enemy towards the player
	enemy.chase_player()
	# check if the player is no longer spotted
	if not(enemy.player_spotted):
		# return to the wandering state
		state_machine.transition_to("Wander")


func exit() -> void:
	# stop the persistance timer before leaving the state
	enemy.persist_timer.stop()
