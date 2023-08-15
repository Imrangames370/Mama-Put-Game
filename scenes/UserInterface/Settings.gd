extends Control

onready var music_slider = $Panel/VBoxContainer/MusicContainer/MusicSlider
onready var sound_fx_slider = $Panel/VBoxContainer/SoundFXContainer/SoundFxSlider


var music = AudioServer.get_bus_index("Music")
var sound_fx = AudioServer.get_bus_index("SoundFX")

func _ready():
	music_slider.change_value(db2linear(music))
	sound_fx_slider.change_value(db2linear(sound_fx))

func _on_back_button_pressed():
	hide()

func set_bus_volume(audio_bus, value) -> void:
	AudioServer.set_bus_volume_db(audio_bus, linear2db(value))

func _on_music_slider_value_changed(value):
	set_bus_volume(music, value)


func _on_sound_fx_slider_value_changed(value):
	set_bus_volume(sound_fx, value)
