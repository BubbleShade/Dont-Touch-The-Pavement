extends CanvasLayer

var init = true
# Called when the node enters the scene tree for the first time.
func _ready():
	get_node("Panel/VolumeSlider").value = LevelInfo.volume
	get_node("Panel/VolumeSliderMusic").value = LevelInfo.music_volume
	init = false

func _on_volume_slider_value_changed(value):
	if(init): return
	LevelInfo.volume = value
	AudioHandler.play(self, LevelInfo.slider_change)
func _on_music_volume_slider_value_changed(value):
	if(init): return
	LevelInfo.music_volume = value
	Sfx.bkg_loop.volume_db = ( (LevelInfo.music_volume - 5)*2 ) -20
	if(LevelInfo.music_volume == 0): Sfx.bkg_loop.volume_db = -1000
	AudioHandler.play(self, LevelInfo.slider_change)
