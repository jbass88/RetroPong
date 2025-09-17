extends Node

@onready var music_player = $AudioPlayerMusic
@onready var sfx_player = $AudioPlayerSfx

# Volume settings (dB)
var music_volume_db := 0.0
var sfx_volume_db := 0.0
var is_muted := false

const AI_SCORE = preload("res://sounds/score/ai_score.ogg")
const PLAYER_SCORE = preload("res://sounds/score/player_score.ogg")

@export var bounce_sounds_low = [
	preload("res://sounds/paddle/Low1.wav"),
	preload("res://sounds/paddle/Low2.wav"),
	preload("res://sounds/paddle/Low3.wav"),
	preload("res://sounds/paddle/Low4.wav"),
	preload("res://sounds/paddle/Low5.wav"),
]
var bounce_sounds_med = [
	preload("res://sounds/paddle/Med1.wav"),
	preload("res://sounds/paddle/Med2.wav"),
	preload("res://sounds/paddle/Med3.wav"),
	preload("res://sounds/paddle/Med4.wav"),
	preload("res://sounds/paddle/Med5.wav"),
	preload("res://sounds/paddle/Med6.wav"),
	preload("res://sounds/paddle/Med7.wav"),
]
var bounce_sounds_high = [
	preload("res://sounds/paddle/High1.wav"),
	preload("res://sounds/paddle/High2.wav"),
	preload("res://sounds/paddle/High3.wav"),
	preload("res://sounds/paddle/High4.wav"),
	preload("res://sounds/paddle/High5.wav"),
	preload("res://sounds/paddle/High6.wav"),
	preload("res://sounds/paddle/High7.wav"),
]

var background_music = [
	preload("res://sounds/music/8-bit-gaming-background-music-358443.mp3"),
	preload("res://sounds/music/arcade-beat-323176.mp3"),
	preload("res://sounds/music/best-game-console-301284.mp3"),
	preload("res://sounds/music/game-gaming-minecraft-background-music-362185.mp3"),
	preload("res://sounds/music/game-mode-on-356552.mp3"), 
	preload("res://sounds/music/game-music-8-bit-console-play-background-intro-theme-350759.mp3"),
	preload("res://sounds/music/game-music-player-console-8bit-background-intro-theme-297305.mp3"),
	preload("res://sounds/music/retro-chiptune-adventure-8-bit-video-game-music-318059.mp3"),
	preload("res://sounds/music/the-return-of-the-8-bit-era-301292.mp3")
]

func _ready():
	update_volume()
	
func _on_audio_player_music_finished() -> void:
	play_background_music()
	
func mute_all():
	is_muted = true
	update_volume()

func play_music(stream: AudioStream):
	music_player.stream = stream
	music_player.play()
	
func play_background_music():
	play_music(background_music.pick_random())

func play_sfx(stream: AudioStream):
	sfx_player.stream = stream
	sfx_player.play()

func play_random_bounce(stream: AudioStream):
	sfx_player.pitch_scale = randf_range(0.95, 1.05)
	play_sfx(stream)

func set_music_volume(db: float):
	music_volume_db = db
	update_volume()

func set_sfx_volume(db: float):
	sfx_volume_db = db
	update_volume()

func stop_music():
	music_player.stop()

func toggle_mute():
	is_muted = !is_muted
	update_volume()

func unmute_all():
	is_muted = false
	update_volume()

func update_volume():
	music_player.volume_db = -80.0 if is_muted else music_volume_db
	sfx_player.volume_db = -80.0 if is_muted else sfx_volume_db
