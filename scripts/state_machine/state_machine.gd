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


# DEFINED FUNCTIONS ======================================================
# transition to different states under the state machine
func transition_to(target_state_name: String, msg: Dictionary = {}) -> void:
	# checks to see if the targeted state exists
	if not has_node(target_state_name):
		return
	
	# leave the current state
	state.exit()
	# get a reference to the targeted state
	state = get_node(target_state_name)
	# enter the state with an optional message
	state.enter(msg)
	# emit a signal saying that we have transitioned states
	emit_signal("transitioned", state.name)


# RUNNING FUNCTIONS ======================================================
func _ready() -> void:
	await(owner.ready)
	# gets all states under StateMachine and sets their "state_machine" property
	# to this node
	for child in get_children():
		child.state_machine = self
	# enter the initial state specified
	state.enter()


# sends unhandled input to the state to deal with
func _unhandled_input(event: InputEvent) -> void:
	state.handle_input(event)


# runs the state's "process" function instead
func _process(delta: float) -> void:
	state.update(delta)


# runs the state's "physics_process" function instead
func _physics_process(delta: float) -> void:
	state.physics_update(delta)
