# help with checking inputs via move_inputs from:
# https://www.reddit.com/r/godot/comments/zu0b0n/comment/j1gduig/?utm_source=share&utm_medium=web2x&context=3

extends PlayerState

var move_inputs = ["mv_up", "mv_down", "mv_left", "mv_right"]


func enter(_msg := {}) -> void:
	player.state_display.text = "Idle"
	player.velocity = Vector2.ZERO


# allows dash to be activated even while not moving
func handle_input(event: InputEvent) -> void:
	if event is InputEventKey:
		if event.pressed and event.keycode == KEY_SPACE:
			if player.can_dash:
				state_machine.transition_to("Dash")


func physics_update(_delta: float) -> void:
	for input in move_inputs:
		if Input.is_action_pressed(input):
			state_machine.transition_to("Move")
	
	# checks if the player is dead via the "dead" bool in Player.gd
	if player.dead:
		state_machine.transition_to("Dead")
