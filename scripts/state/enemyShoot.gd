extends State
class_name EnemyShoot

@export var enemy : CharacterBody3D
var target = CharacterBody3D
#@onready var raycast = $"../../RayCast"
@onready var shootDetection : Area3D = $"../../PlayerShootRange"
@onready var cooldown = $"../../Timer"

func Enter():
	enemy.velocity = Vector3.ZERO
	var overlaps = shootDetection.get_overlapping_bodies()
	if !overlaps.is_empty():
		target = overlaps[0]

func Update(delta):
	if target:
		enemy.look_at(target.position + Vector3(0, 0.5, 0), Vector3.UP, true)
		if cooldown.is_stopped():
			enemy.shoot(target)
			cooldown.start()
	else:
		Transitionned.emit(self, "follow")


func _on_player_shoot_range_body_entered(body):
	target = body

func _on_player_shoot_range_body_exited(body):
	target = null
