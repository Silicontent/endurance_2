class_name GameMaster
extends Node2D

# gets a reference to the player
@onready var player: Player = $Player
# gets a reference to the HUD display
@onready var hud := $HUD
# gets a reference to the survival timer, which keeps track of how long the game has lasted
@onready var survival_timer = $SurvivalTimer
# declares a variable to hold the player's score, starts at 0
var score: int = 0
# declares a variable to hold the amount of enemies killed, starts at 0
var enemies_killed: int = 0


# DEFINED FUNCTIONS ======================================================
# change the score and update the HUD to display the new values
func set_scores(score_new: int, kills: int) -> void:
	score += score_new
	enemies_killed += kills
	hud.set_values(score, enemies_killed)


# RUNNING FUNCTIONS ======================================================
func _ready() -> void:
	# reset the scores to 0
	set_scores(0, 0)


# SIGNALS ================================================================
# triggered whenever the survival timer ends
func _on_survival_timer_timeout():
	# add 1 to the normal score
	set_scores(1, 0)


# triggered whenever the player kills an enemy
func _on_enemy_killed(reward):
	# add 1 to the amount of enemies killed
	# add whatever the enemy's score reward is to the score
	set_scores(reward, 1)


# triggered when the player emits the signal saying it has died
func _on_player_dead():
	# stop the survival timer, preventing any more points from being gained
	survival_timer.stop()


