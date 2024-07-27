extends Control

@export var LevelElixer : int = 100
@onready var tint : ColorRect = get_node("ScreenTint")
@onready var sunManipulator : HSlider = get_node("Canvas/Panel/SunManipulator")
@onready var elixirVial : TextureProgressBar = get_node("Canvas/ElixirVial")
@onready var elixirEmptyWarn : RichTextLabel = get_node("Canvas/ElixerEmptyWarning")
@onready var pressR : RichTextLabel = get_node("Canvas/Tip1")
@onready var elixirDisplay : RichTextLabel = get_node("Canvas/ElixirVial/Percent")
@onready var synthloop = AudioHandler.createLoop(self, LevelInfo.synth, -10, 0.4)
var Rtime = 0
# Called when the node enters the scene tree for the first time.
func _ready():
	LevelInfo.maxElixir = LevelElixer
	elixirVial.max_value = LevelInfo.maxElixir 
	LevelInfo.restartLevel.connect(restart.bind(true))
	sunManipulator.drag_started.connect(dragStart)
	sunManipulator.drag_ended.connect(dragEnd)
	restart(false)
func restart(playsound: bool):
	if(playsound): 
		AudioHandler.play(self, LevelInfo.restart_sound, -10)
	LevelInfo.ShadowProgress = 0.5
	sunManipulator.value = 0.5
	LevelInfo.elixir = LevelInfo.maxElixir
	sunManipulator.editable = true
	elixirEmptyWarn.visible = false
	pressR.visible = false
	elixirDisplay.visible = true
	synthloop.stream_paused = true
	updateInterface()
	print(LevelInfo.elixir)
func setScreenTint():
	var distFromMiddle = abs((LevelInfo.ShadowProgress * 2) - 1) * 1/0.9
	var r = 255 * distFromMiddle
	
	if(distFromMiddle < 0.4):
		tint.color = Color(0, 0, 0, 0)
		return
	var alpha = (distFromMiddle - 0.4)/2
	if(distFromMiddle < 0.8):
		tint.color = Color(0, 0, 0, alpha)
		return
	
	distFromMiddle = (distFromMiddle - 0.8) * 1/0.2
	tint.color = Color(distFromMiddle*0.5, distFromMiddle*0.25, 0, alpha)
	print()
	return
var dragging = false
func dragStart(): 
	synthloop.stream_paused = false
func dragEnd(valueChanged : bool):
	synthloop.stream_paused = true

	#tint.color = Color(1-distFromMiddle, (1-distFromMiddle)*0.5, 0, distFromMiddle)
	
		
func updateInterface():
	var newShadowProgress = 1-sunManipulator.value
	var elixirDiff = abs(LevelInfo.ShadowProgress - newShadowProgress)*100
	setScreenTint()
	LevelInfo.ShadowProgress = newShadowProgress
	LevelInfo.elixir -= elixirDiff
	elixirDisplay.text = "[center]%s ml" % round(LevelInfo.elixir)
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	# https://www.reddit.com/r/godot/comments/cjigi4/how_do_i_make_hitting_the_esc_key_exit_the_game/?rdt=4797
	if(sunManipulator.editable):
		var input_direction = Input.get_axis("UI_left", "UI_right")
		sunManipulator.value += input_direction * delta/5
	if Input.is_action_just_pressed("ui_cancel") && !MenuHandler.sceneActive:
		MenuHandler.genScene("res://Scenes/Menus/settings.tscn", "Settings")
		
	if(Input.is_action_pressed("restart")):
		Rtime += delta
		if(Rtime > 0.2): 
			LevelInfo.restartLevel.emit()
			Rtime = -0.8
	else: Rtime = 0
	if(LevelInfo.elixir > 0):
		updateInterface()
	else:
		synthloop.stream_paused = true
		sunManipulator.editable = false
		elixirDisplay.visible = false
		elixirEmptyWarn.visible = true
		pressR.visible = true
	elixirVial.value = LevelInfo.elixir
