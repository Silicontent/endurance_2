extends PlayerState


# sets the player's speed to the faster speed, then hands control over to the
# Move state, where the dash can be disabled after DashTimer times out
func enter(_msg := {}) -> void:
	player.state_display.text = "Dash"
	player.speed_addition = owner.MAX_ADDITION
	player.invulnerable = true
	# reset the cooldown time (consider moving this elsewhere or using a signal)
	player.cooldown_timer.reset_cooldown()
	player.dash_timer.start()
	state_machine.transition_to("Move")
