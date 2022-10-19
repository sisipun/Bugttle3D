class_name Bug
extends KinematicBody


signal dead(bug)


var team: int = -1 setget , get_team
var x: int = -1 setget set_x, get_x
var y: int = -1 setget set_y, get_y
var position: Vector2 = Vector2.ZERO setget , get_position
var max_health: int = 0 setget , get_max_health
var health: int = 0 setget , get_health
var max_move_range: int = 0 setget , get_max_move_range
var move_range: int = 0 setget , get_move_range
var max_attack_range: int = 0 setget , get_max_attack_range
var attack_range: int = 0 setget , get_attack_range
var attack_power: int = 0 setget , get_attack_power
var skills: Array = [] setget , get_skills
var dead: bool = false setget , is_dead


func _ready() -> void:
	self.dead = false
	self.health = self.max_health
	self.move_range = self.max_move_range
	self.attack_range = self.max_attack_range


func init(_x: int, _y: int, bug_team: int, type: BugType) -> Bug:
	self.x = _x
	self.y = _y
	self.team = bug_team	
	self.max_health = type.health
	self.health = type.health
	self.max_move_range = type.move_range
	self.move_range = type.move_range
	self.max_attack_range = type.attack_range
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
	self.move_range = self.max_move_range
	self.attack_range = self.max_attack_range


func after_turn() -> void:
	pass


func get_x() -> int:
	return x


func set_x(_x: int) -> void:
	x = _x


func get_y() -> int:
	return y


func set_y(_y: int) -> void:
	y = _y


func get_position() -> Vector2:
	return Vector2(x, y)


func set_position(_x: int, _y: int) -> void:
	x = _x
	y = _y


func move(path_info: PathInfo) -> void:
	move_range -= path_info.cost


func get_max_health() -> int:
	return max_health


func get_health() -> int:
	return health


func get_max_move_range() -> int:
	return max_move_range


func get_move_range() -> int:
	return move_range


func get_max_attack_range() -> int:
	return max_attack_range


func get_attack_range() -> int:
	return attack_range


func get_attack_power() -> int:
	return attack_power


func get_team() -> int:
	return team


func is_dead() -> bool:
	return dead


func get_skills() -> Array:
	return skills


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
