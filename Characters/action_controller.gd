extends Node2D

@export var multimode := false
var current_actions: Array[Action] = []
var actions: Array[Action] = []
var direction := Vector2.ZERO
@onready var stationary := $Stationary
var acted = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for child in get_children():
		if child is Action:
			actions.append(child)
	set_action(stationary)
	Global.half_beat.connect(reset_act)

func change_action(new_act: Action):
	if acted == false:
		var super_act = false
		if Global.beat_percent >= 0.7 or Global.beat_percent <= 0.1:
			super_act = true
		current_actions.clear()
		current_actions.append(new_act)
		act(super_act)
		

func set_action(act: Action):
	current_actions.clear()
	current_actions.append(act)

func act(super_act):
	print(Global.beat_percent)
	if multimode == false:
		current_actions[0].play(direction, super_act)
		set_action(stationary)
	acted = true

func reset_act():
	acted = false
