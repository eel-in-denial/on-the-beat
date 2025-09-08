extends Node2D

var hearts = []
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	hearts = get_children()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func lose_health(value: int):
	hearts[value].visible = false
