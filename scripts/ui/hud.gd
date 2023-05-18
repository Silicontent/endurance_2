extends CanvasLayer

@onready var score_display = $Score
@onready var killed_display = $Killed
var game_master: GameMaster


func _ready() -> void:
	# get reference to the main game scene ("game master") for use later
	await(owner.ready)
	game_master = owner as GameMaster
	assert(game_master != null)


func set_values(score: int, killed: int) -> void:
	score_display.text = str(score)
	killed_display.text = str(killed)
