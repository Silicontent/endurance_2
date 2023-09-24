extends PlayerState


# sets the player's speed to the faster speed, then hands control over to the
# Move state, where the dash can be disabled after DashTimer times out
func enter(_msg := {}) -> void:
	# sets debug text
	player.state_display.text = "Dash"
	# sets the player's speed addition to the maximum addition allowed
	player.speed_addition = owner.MAX_ADDITION
	# makes the player invulnerable
	player.invulnerable = true
	# reset the cooldown time (consider moving this elsewhere or using a signal)
	player.cooldown_timer.reset_cooldown()
	# begin the dash timer to make the dash last for a certain amount of time
	player.dash_timer.start()
	# transition to the moving state to handle ending the dash
	state_machine.transition_to("Move")
