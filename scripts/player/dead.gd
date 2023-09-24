extends PlayerState


func enter(_msg := {}) -> void:
	# set debug text
	player.state_display.text = "Dead"
	# hide the player (TODO: replace with animation)
	player.visible = false
	# run the death function in the player to properly trigger the death
	player.die()
