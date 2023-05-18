# code for the State and StateMachine from:
# https://www.gdquest.com/tutorial/godot/design-patterns/finite-state-machine/

# assisstance with implementation from:
# https://www.reddit.com/r/godot/comments/zt75lh/comment/j1c9kct/?utm_source=share&utm_medium=web2x&context=3

class_name StateMachine
extends Node

# emitted when transitioning to new state
signal transitioned(state_name)

# contains path to the starting state, exported so we can set the initial
# state in the editor
@export var initial_state := NodePath()

# current active state, set to initial_state at the start of the game
@onready var state: State = get_node(initial_state)


func _ready() -> void:
	await(owner.ready)
	# gets all states under StateMachine and sets their "state_machine" property
	# to this node
	for child in get_children():
		child.state_machine = self
	state.enter()


# sends input events to the state's handle_input func
# the same occurs for the _process() and _physics_process() functions
func _unhandled_input(event: InputEvent) -> void:
	state.handle_input(event)


func _process(delta: float) -> void:
	state.update(delta)


func _physics_process(delta: float) -> void:
	state.physics_update(delta)


# calls current state's exit() function, changes the active state, then calls the new state's
# enter() function
# optionally passes "msg" parameter to new state's enter() function
func transition_to(target_state_name: String, msg: Dictionary = {}) -> void:
	if not has_node(target_state_name):
		return
	
	state.exit()
	state = get_node(target_state_name)
	state.enter(msg)
	emit_signal("transitioned", state.name)
