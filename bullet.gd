extends CharacterBody2D

const SPEED: float = 200.0
const BOUNCE_OFFSET: float = 5.0

var direction: Vector2 = Vector2.RIGHT


func set_direction(new_direction: Vector2) -> void:
	direction = new_direction.normalized()
	rotation = direction.angle()


func _physics_process(delta: float) -> void:

	var collision = move_and_collide(direction * SPEED * delta)

	if collision:
		var normal = collision.get_normal()

		# Reflect the bullet's direction
		direction = direction.bounce(normal).normalized()

		# Move slightly away from the wall
		global_position += normal * BOUNCE_OFFSET

		# Update bullet rotation
		rotation = direction.angle()


func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()
