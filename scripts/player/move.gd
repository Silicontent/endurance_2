extends PlayerState


# set debug text
func enter(_msg := {}) -> void:
	player.state_display.text = "Move"


# handling transitions between different states
func physics_update(_delta: float) -> void:
	# get the strength of each axis' movement
	var input_dir_x: float = (Input.get_action_strength("mv_right")-Input.get_action_strength("mv_left"))
	var input_dir_y: float = (Input.get_action_strength("mv_down")-Input.get_action_strength("mv_up"))
	
	# run the move function in the player script, which actually handles movement
	player.move()
	
	# checks if the player isn't moving
	if is_equal_approx(input_dir_x, 0.0) and is_equal_approx(input_dir_y, 0.0):
		state_machine.transition_to("Idle")
	
	# checks if the player is dead via "dead: bool" in the player script
	if player.dead:
		state_machine.transition_to("Dead")


# DASH MECHANICS =========================================================
func handle_input(event: InputEvent) -> void:
	# checks if the player can dash and has pressed the key to do so
	if event is InputEventKey:
		if event.pressed and event.keycode == KEY_SPACE:
			if player.can_dash:
				state_machine.transition_to("Dash")


# triggered when the dash timer runs out, signifying the end of the dash
func _on_dash_timer_timeout():
	# set the player's speed addition to 0, which sets the total speed to the base speed
	player.speed_addition = 0
	# TODO: change this to allow iframes
	player.invulnerable = false
