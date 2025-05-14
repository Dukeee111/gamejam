extends StaticBody2D

@export var jump_force = 100+50

var can_bounce = true
var original_extents: Vector2

func _ready():
	# Store the original size of the collision shape to restore later
	original_extents = $CollisionShape2D.shape.extents
	$AnimatedSprite2D.play("idle")

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body is PlayerController and can_bounce:
		can_bounce = false
		body._spring_jump(jump_force)
		$AnimatedSprite2D.play("extend")
		# Shrink the collision box to prevent double-triggers during animation
		$CollisionShape2D.shape.extents = Vector2(original_extents.x, 10)

func _on_animated_sprite_2d_animation_finished() -> void:
	if $AnimatedSprite2D.animation == "extend":
		# Reset animation and collision shape
		$AnimatedSprite2D.play("idle")
		$CollisionShape2D.shape.extents = original_extents
		can_bounce = true
