# help with checking inputs via move_inputs from:
# https://www.reddit.com/r/godot/comments/zu0b0n/comment/j1gduig/?utm_source=share&utm_medium=web2x&context=3

extends PlayerState

# specifies allowed inputs
var move_inputs = ["mv_up", "mv_down", "mv_left", "mv_right"]


# starting conditions for the state
func enter(_msg := {}) -> void:
	# set debug text
	player.state_display.text = "Idle"
	# reset the player's velocity
	player.velocity = Vector2.ZERO


# allows dash to be activated even while not moving
func handle_input(event: InputEvent) -> void:
	# performs multiple checks to see if the player can dash
	if event is InputEventKey:
		if event.pressed and event.keycode == KEY_SPACE:
			if player.can_dash:
				# tell the state machine to transition to the dash state
				state_machine.transition_to("Dash")


func physics_update(_delta: float) -> void:
	# if the player tries to move, immediately go to the moving state
	for input in move_inputs:
		if Input.is_action_pressed(input):
			state_machine.transition_to("Move")
	
	# checks if the player is dead via "dead: bool" in the player script
	if player.dead:
		# transition to the dead state
		state_machine.transition_to("Dead")
