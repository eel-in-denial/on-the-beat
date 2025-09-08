extends Action

@export var speed := 12
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	timer_duration = Global.sec_per_beat


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	super(delta)
	if timer_playing:
		if timer > Global.sec_per_beat * 0.2:
			body.velocity = Vector2.ZERO
			body.set_invulnerable(false)
func play(direction, super_act):
	body.velocity = direction*speed * Global.bpm
	if super_act:
		body.set_invulnerable(true)
	timer_start()
	
