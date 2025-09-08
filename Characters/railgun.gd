extends Area2D

@onready var countdown = $Node2D
@onready var projectile_line = $Line2D
var line = preload("res://World/line_2d.tscn")
var line_material = preload("res://Characters/enemy_railgun.tres")
var max_bound = 60
var min_bound = -60
@export var counter := 3
var line_list = []


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for l in range(counter):
		var y = min_bound + ((max_bound - min_bound) * (l+1)/(counter + 1))
		create_line(Vector2(50, y), Vector2(2000, y))
	projectile_line.material.set_shader_parameter("glow_color", Color.ORANGE)


func hide_lines():
	for l in line_list:
		l.visible = false
		
func show_line():
	var i = 0
	var l = line_list[i]
	while l.visible == true and i < line_list.size():
		l = line_list[i]
		i += 1
		
	l.visible = true

func create_line(point_1: Vector2, point_2: Vector2):
	var new_line: Line2D = line.instantiate()
	new_line.material = line_material
	new_line.add_point(point_1)
	new_line.add_point(point_2)
	new_line.visible = false
	add_child(new_line)
	line_list.append(new_line)

func ready_line_colour():
	projectile_line.material.set_shader_parameter("glow_color", Color.RED)
func reset_line_colour():
	projectile_line.material.set_shader_parameter("glow_color", Color.ORANGE)
