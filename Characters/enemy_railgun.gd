extends Area2D

@onready  var railgun = $Area2D
@onready var collision = $Area2D/CollisionShape2D
@onready var beam = $Area2D/Polygon2D
@export var init_rest_beats := 3
@export var init_charge_beats := 4
var rand_offset := 1
var rest_beats := init_rest_beats
var charge_beats := init_charge_beats
var player
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	player = get_tree().get_nodes_in_group("player")[0]
	reset_gun()
	Global.beat.connect(beat)
	rand_offset = randi_range(0, 4)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
func beat():
	if rand_offset > 0:
		rand_offset -= 1
	elif rest_beats > 0:
		if beam.visible == true:
			reset_gun()
		rest_beats -= 1
	elif charge_beats > 0:
		if charge_beats == init_charge_beats:
			railgun.visible = true
			railgun.look_at(player.global_position)
		else:
			railgun.show_line()
		charge_beats -= 1
		if charge_beats == 0:
			railgun.ready_line_colour()
	else:
		collision.disabled = false
		beam.visible = true
		rest_beats = init_rest_beats
		charge_beats = init_charge_beats

func reset_gun():
	railgun.visible = false
	collision.disabled = true
	beam.visible = false
	railgun.hide_lines()
	railgun.reset_line_colour()
