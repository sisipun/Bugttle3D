class_name Bug
extends KinematicBody


signal dead(bug)


var team: int = -1
var type: BugType = null
var x: int = -1
var y: int = -1
var position: Vector2 = Vector2.ZERO setget set_position, get_position
var max_health: int = 0
var health: int = 0
var max_move_range: int = 0
var move_range: int = 0
var max_attack_range: int = 0
var attack_range: int = 0
var attack_power: int = 0
var skills: Array = []
var dead: bool = false


func _ready() -> void:
	self.dead = false


func init(_x: int, _y: int, bug_team: int, _type: BugType) -> Bug:
	self.x = _x
	self.y = _y
	self.team = bug_team
	self.type = _type
	self.health = type.health
	self.move_range = type.move_range
	self.attack_range = type.attack_range
	self.attack_power = type.attack_power
	self.skills = type.skills
	self.dead = false
	$Body.mesh = type.mesh
	$Body.translation = type.translation
	$Body.rotation_degrees = type.rotation_degrees
	$Body.scale = type.scale
	return self


func before_turn() -> void:
	self.move_range = self.type.move_range
	self.attack_range = self.type.attack_range


func after_turn() -> void:
	pass


func get_position() -> Vector2:
	return Vector2(x, y)


func set_position(_position: Vector2) -> void:
	x = int(_position.x)
	y = int(_position.y)


func set_position_distruct(_x: int, _y: int) -> void:
	x = _x
	y = _y


func move(path_info: PathInfo) -> void:
	move_range -= path_info.cost


func attack(bug: Bug) -> void:
	if !dead:
		bug.hit(attack_power)
		attack_range = 0


func hit(power: int) -> void:
	health -= power
	if health <= 0:
		health = 0
		dead = true
		emit_signal("dead")
