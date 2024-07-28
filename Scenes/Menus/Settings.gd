extends CanvasLayer

var init = true
# Called when the node enters the scene tree for the first time.
func _ready():
	get_node("Panel/VolumeSlider").value = LevelInfo.volume
	init = false

func _on_volume_slider_value_changed(value):
	if(init): return
	LevelInfo.volume = value
	AudioHandler.play(self, LevelInfo.slider_change)
