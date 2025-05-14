extends Area2D
var area_path = "res://Asserts/Scenes/Areas/"

func _on_body_entered(body: Node2D) -> void:
	
	if body is PlayerController:
		game_state.current_area += 1
		var next_area = game_state.current_area
		var full_path = area_path + "area_" + str(next_area) + ".tscn"
		get_tree().change_scene_to_file(full_path)
		print("Player has moved to area " + str(next_area) + "!")
		print(next_area)
