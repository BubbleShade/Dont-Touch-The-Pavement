extends TextureButton
@onready var animPlayer = $AnimationPlayer

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_start_pressed():
	#hide() # https://forum.godotengine.org/t/how-to-make-an-button-invisible/9324/3
	animPlayer.play("Click2")
	Sfx.musicEnable = true
	SceneTransition.load_scene("Levels/Level1", "DropDown")

func _on_hover():
	animPlayer.play("Hover")

func _on_unhover():
	animPlayer.play_backwards("Hover")
