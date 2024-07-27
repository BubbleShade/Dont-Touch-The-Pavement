extends CanvasLayer


# Called when the node enters the scene tree for the first time.
func _ready():
	get_tree().paused = true


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("ui_cancel"):
		_unpause()


func _unpause():
	if len(MenuHandler.back_screen) <= 1:
		get_tree().paused = false
	MenuHandler.returnToScene()
