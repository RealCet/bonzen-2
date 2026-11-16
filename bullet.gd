extends CharacterBody2D

const SPEED: float = 200
const BOUNCE_OFFSET: float = 5

var direction: Vector2 = Vector2.RIGHT


func set_direction(new_direction: Vector2) -> void:
	direction = new_direction.normalized()
	rotation = direction.angle()


func _physics_process(delta: float) -> void:

	var collision = move_and_collide(direction * SPEED * delta)

	if collision:
		var object = collision.get_collider()

		if object.is_in_group("walls"):
			var normal = collision.get_normal()
			direction = direction.bounce(normal).normalized()
			global_position += normal * BOUNCE_OFFSET
			rotation = direction.angle()

		elif object.is_in_group("enemies"):
			object.queue_free()
			var orb = preload("res://eye.tscn")
			get_tree().current_scene.add_child(orb)
			orb.global_position = object.global_position
			queue_free()



func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()
