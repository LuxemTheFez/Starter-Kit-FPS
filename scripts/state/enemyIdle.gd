extends State
class_name EnemyIdle

@export var enemy : CharacterBody3D
@export var move_speed := 2.0

var move_direction: Vector3
var wander_time: float

func random_wander():
	move_direction = Vector3(randf_range(-0.5,0.5),0,randf_range(-0.5,0.5)).normalized()
	wander_time = randf_range(2,5)

func Enter():
	random_wander()

func Update(delta):
	if wander_time > 0:
		wander_time -= delta
	else:
		random_wander()

func Physics_Update(delta: float):
	if enemy:
		enemy.velocity = move_direction * move_speed


func _on_player_detection_body_entered(body):
	Transitionned.emit(self, "follow")
