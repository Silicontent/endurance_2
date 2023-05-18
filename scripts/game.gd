class_name GameMaster
extends Node2D

@onready var player: Player = $Player
@onready var hud := $HUD
@onready var survival_timer = $SurvivalTimer
var score: int = 0
var enemies_killed: int = 0


func _ready() -> void:
	hud.set_values(score, enemies_killed)


func _on_survival_timer_timeout():
	score += 1
	# TODO: consider a better way to send values to HUD
	hud.set_values(score, enemies_killed)


func _on_player_dead():
	survival_timer.stop()
