extends Path2D
class_name MovingPlatform

@export var path_follow_2D: PathFollow2D
@export var path_time = 1.0
@export var ease : Tween.EaseType
@export var transition : Tween.TransitionType


func _ready():
	move_tween()


func move_tween():
	var tween = get_tree().create_tween().set_loops()
	tween.tween_property(path_follow_2D,"progress_ratio",1.0,path_time).set_ease(ease).set_trans(transition)
	tween.tween_property(path_follow_2D,"progress_ratio",0.0,path_time).set_ease(ease).set_trans(transition)
