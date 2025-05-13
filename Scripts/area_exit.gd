extends Area2D

var current_area = 1
var area_path = "res://Asserts/Scenes/Areas/"

func _on_body_entered(body: Node2D) -> void:
	current_area += 1
	var full_path = area_path + "area_" + str(current_area) + ".tscn"
	if body is PlayerController:
		get_tree().change_scene_to_file(full_path)
		print("Player has moved to area " + str(current_area) + "!")
