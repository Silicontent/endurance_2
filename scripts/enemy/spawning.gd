extends EnemyState


func enter(_msg := {}) -> void:
	# set debug label
	enemy.get_node("DebugLabel").text = "Spawning"
	
	# make the enemy invincible while it is spawning
	enemy.invulnerable = true
	# begin the enemy's spawning timer
	enemy.spawn_timer.start()


# triggered when the enemy's spawning timer runs out
func _on_spawn_timer_timeout():
	# automatically put the enemy into the wandering state
	state_machine.transition_to("Wander")


func exit() -> void:
	# when the enemy is finished spawning, remove invincibility
	enemy.invulnerable = false
