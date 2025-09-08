extends Node

signal beat
signal half_beat
var bpm := 140
var sec_per_beat := 0.0
var prev_song_position := 0.0
var song_position := 0.0
var song_beats_position := 0.0
var song_beats_int := 0
var song_beats_prev := 0.0
var beat_time := 0.0
var beat_percent := 0.0
var delayed_beat_percent := 0.0
var beat_played := false
@onready var bg_music = $BGM
@onready var metronome = $Metronome
@export var metronome_enabled := true
@export var time_delay := 0.1


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	new_room(preload("res://Assets/Round 4.ogg"), 120)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	prev_song_position = song_position
	song_position = bg_music.get_playback_position() + AudioServer.get_time_since_last_mix() - AudioServer.get_output_latency()
	beat_time += song_position - prev_song_position
	beat_percent = beat_time / sec_per_beat
	song_beats_position = song_position / sec_per_beat
	song_beats_int = int(floor(song_beats_position))
	if song_beats_prev < song_beats_int:
		beat.emit()
		if metronome_enabled:
			metronome.play()
		song_beats_prev = song_beats_int
		beat_time = 0.0
		beat_percent = beat_time / sec_per_beat
		beat_played = false
	elif song_beats_prev > song_beats_int:
		song_beats_prev = 0
		beat_time = 0.0
		beat_played = false
	if beat_percent > 0.5 and not beat_played:
		half_beat.emit()
		beat_played = true
	

func new_room(new_song: Resource, new_bpm: int):
	bg_music.stream = new_song
	bpm = new_bpm
	sec_per_beat = 60.0 / bpm
	bg_music.play()
	if metronome_enabled:
		metronome.play()
