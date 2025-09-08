extends Node
class_name Action

@export var body: CharacterBody2D
var time_since_action_pressed := 0.0
var timer := 0.0
var timer_playing = false
var timer_duration = 1.0
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if timer_playing:
		timer += delta
		if timer > timer_duration:
			timer_stop()
func play(direction, super_act):
	pass

func timer_start():
	timer_playing = true
	timer = 0.0

func timer_stop():
	timer_playing = false
