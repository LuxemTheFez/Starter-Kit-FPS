extends State
class_name EnemyFollow

@export var enemy: CharacterBody3D
@export var move_speed:= 4
var player: CharacterBody3D

@onready var visionDetection : Area3D = $"../../PlayerDetection"
@onready var raycast = $"../../RayCast"

func Enter():
	var overlaps = visionDetection.get_overlapping_bodies()
	if !overlaps.is_empty():
		player = overlaps[0]

func Physics_Update(delta: float):
	if player:
		var direction = player.global_position - enemy.global_position 
		
		enemy.velocity = direction.normalized() * move_speed 

		enemy.look_at(player.position + Vector3(0, 0.5, 0), Vector3.UP, true)

	else: 
		#enemy.look_at(Vector3.FORWARD,Vector3.UP,true)
		enemy.rotation = Vector3.ZERO
		Transitionned.emit(self, "idle")

func _on_player_detection_body_entered(body):
	player = body

func _on_player_detection_body_exited(body):
	player = null


func _on_player_shoot_range_body_entered(body):
	Transitionned.emit(self, "shoot")
