extends CanvasLayer

# gets a reference to the score and enemies killed labels
@onready var score_display = $Score
@onready var killed_display = $Killed
# creates an empty variable that can only take nodes with the type GameMaster
var game_master: GameMaster


# DEFINED FUNCTIONS ======================================================
# change the values displayed
func set_values(score: int, killed: int) -> void:
	# set the score and killed displays
	score_display.text = str(score)
	killed_display.text = str(killed)


# RUNNING FUNCTIONS ======================================================
func _ready() -> void:
	# wait for the owner to enter the scene tree, which is required for
	# the next line to function properly
	await(owner.ready)
	# get reference to the main game scene ("game master") for use later
	game_master = owner as GameMaster
	# make sure that the game scene actually exists
	assert(game_master != null)
