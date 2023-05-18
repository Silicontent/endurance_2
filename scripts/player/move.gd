extends PlayerState


func enter(_msg := {}) -> void:
	player.state_display.text = "Move"


func physics_update(_delta: float) -> void:
	var input_dir_x: float = (Input.get_action_strength("mv_right")-Input.get_action_strength("mv_left"))
	var input_dir_y: float = (Input.get_action_strength("mv_down")-Input.get_action_strength("mv_up"))
	
	player.move()
	
	# checks if the player isn't moving
	if is_equal_approx(input_dir_x, 0.0) and is_equal_approx(input_dir_y, 0.0):
		state_machine.transition_to("Idle")
	
	# checks if the player is dead via the "dead" bool in Player.gd
	if player.dead:
		state_machine.transition_to("Dead")


# DASH MECHANICS (moved from DashMachine to MoveMachine to eliminate the need
# for two state machines)
func handle_input(event: InputEvent) -> void:
	if event is InputEventKey:
		if event.pressed and event.keycode == KEY_SPACE:
			if player.can_dash:
				state_machine.transition_to("Dash")


func _on_dash_timer_timeout():
	player.speed_addition = 0
	# TODO: change this to allow iframes
	player.invulnerable = false
