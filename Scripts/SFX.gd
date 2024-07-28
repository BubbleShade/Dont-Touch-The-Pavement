extends Node

var bkg_music = load("res://Sound/Electro.wav")
@onready
var bkg_loop = AudioHandler.createLoop(self, bkg_music, -20, 1)
# Called when the node enters the scene tree for the first time.
func _ready():
	print("Hello")
	pass # Replace with function body.s


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
