extends Control

@export var LevelElixer : int = 100
@onready var sunManipulator : HSlider = get_node("SunManipulator")
@onready var elixirVial : TextureProgressBar = get_node("ElixirVial")
# Called when the node enters the scene tree for the first time.
func _ready():
	LevelInfo.maxElixir = LevelElixer
	LevelInfo.elixir = LevelElixer
	elixirVial.max_value = LevelInfo.maxElixir 
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var elixirDiff = abs(LevelInfo.ShadowProgress - sunManipulator.value)*100
	if(LevelInfo.elixir > 0):
		sunManipulator.editable = true
		LevelInfo.ShadowProgress = sunManipulator.value
		LevelInfo.elixir -= elixirDiff
	else:
		sunManipulator.editable = false
	elixirVial.value = LevelInfo.elixir
