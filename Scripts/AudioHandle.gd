# Copyright © 2019-2020 Hugo Locurcio and contributors - MIT License
# See `LICENSE.md` included in the source distribution for details.
class_name AudioHandler
extends Node

enum Type {
	NON_POSITIONAL,
	POSITIONAL_2D,
}
static func get_vol():
	return (LevelInfo.volume - 5) * 4

# Plays a sound. The AudioStreamPlayer node will be added to the `parent`
# specified as parameter.
static func play(parent: Node, stream: AudioStream, volume_db: float = 0.0, pitch_scale: float = 1.0) -> void:
	var audio_stream_player := AudioStreamPlayer.new()
	volume_db += get_vol()
	parent.add_child(audio_stream_player)
	audio_stream_player.process_mode = Node.PROCESS_MODE_ALWAYS
	audio_stream_player.bus = "Effects"
	audio_stream_player.stream = stream
	audio_stream_player.volume_db = volume_db
	audio_stream_player.pitch_scale = pitch_scale
	
	audio_stream_player.play()
	audio_stream_player.connect("finished", audio_stream_player.queue_free)
	

# Plays a sound. The AudioStreamPlayer node will be added to the `parent`
# specified as parameter.
static func playForTime(parent: Node, stream: AudioStream, volume_db: float = 0.0, pitch_scale: float = 1.0, time: float = 1.0) -> void:
	var audio_stream_player := AudioStreamPlayer.new()
	volume_db += get_vol()
	parent.add_child(audio_stream_player)
	audio_stream_player.process_mode = Node.PROCESS_MODE_ALWAYS
	audio_stream_player.bus = "Effects"
	audio_stream_player.stream = stream
	audio_stream_player.volume_db = volume_db
	audio_stream_player.pitch_scale = pitch_scale
	
	audio_stream_player.play()
	audio_stream_player.connect("finished", audio_stream_player.queue_free)
	var timer := Timer.new()
	audio_stream_player.add_child(timer)
	timer.wait_time = time
	timer.start()
	timer.timeout.connect(audio_stream_player.queue_free)

static func playSection(parent: Node, stream: AudioStream, volume_db: float = 0.0, pitch_scale: float = 1.0, startTime: float = 0.0, time: float = 1.0) -> void:
	var audio_stream_player := AudioStreamPlayer.new()
	volume_db += get_vol()
	audio_stream_player.process_mode = Node.PROCESS_MODE_ALWAYS
	parent.add_child(audio_stream_player)
	audio_stream_player.bus = "Effects"
	audio_stream_player.stream = stream
	audio_stream_player.volume_db = volume_db
	audio_stream_player.pitch_scale = pitch_scale
	
	audio_stream_player.play(startTime)
	audio_stream_player.connect("finished", audio_stream_player.queue_free)
	var timer := Timer.new()
	audio_stream_player.add_child(timer)
	timer.wait_time = time
	timer.start()
	timer.timeout.connect(audio_stream_player.queue_free)

	
# Plays a sound. The AudioStreamPlayer node will be added to the `parent`
# specified as parameter.
static func playAtTime(parent: Node, stream: AudioStream, volume_db: float = 0.0, pitch_scale: float = 1.0, time : float = 0.0) -> void:
	var audio_stream_player := AudioStreamPlayer.new()
	volume_db += get_vol()
	audio_stream_player.process_mode = Node.PROCESS_MODE_ALWAYS
	parent.add_child(audio_stream_player)
	audio_stream_player.bus = "Effects"
	audio_stream_player.stream = stream
	audio_stream_player.volume_db = volume_db
	audio_stream_player.pitch_scale = pitch_scale
	
	audio_stream_player.play(time)
	audio_stream_player.connect("finished", audio_stream_player.queue_free)

	
static func loop(parent: Node, stream: AudioStream, volume_db: float = 0.0, pitch_scale: float = 1.0) -> void:
	var audio_stream_player := AudioStreamPlayer.new()
	volume_db += get_vol()
	audio_stream_player.process_mode = Node.PROCESS_MODE_ALWAYS
	parent.add_child(audio_stream_player)
	audio_stream_player.bus = "Effects"
	audio_stream_player.stream = stream
	audio_stream_player.volume_db = volume_db
	audio_stream_player.pitch_scale = pitch_scale
	audio_stream_player.play()
	audio_stream_player.connect("finished", audio_stream_player.play)
	
static func createLoop(parent: Node, stream: AudioStream, volume_db: float = 0.0, pitch_scale: float = 1.0) -> AudioStreamPlayer:
	var audio_stream_player := AudioStreamPlayer.new()
	volume_db += get_vol()
	audio_stream_player.process_mode = Node.PROCESS_MODE_ALWAYS
	
	parent.add_child(audio_stream_player)
	audio_stream_player.bus = "Effects"
	audio_stream_player.stream = stream
	audio_stream_player.volume_db = volume_db
	audio_stream_player.pitch_scale = pitch_scale
	audio_stream_player.play()
	audio_stream_player.connect("finished", audio_stream_player.play)
	audio_stream_player.stream_paused = true
	return audio_stream_player
