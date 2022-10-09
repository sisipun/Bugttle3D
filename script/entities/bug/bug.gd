class_name Bug
extends KinematicBody


signal dead(bug)


var team: int = -1 setget , get_team
var move_range: int = 0 setget , get_move_range
var attack_power: int = 0 setget , get_attack_power
var attack_range: int = 0 setget , get_attack_range
var dead: bool = false setget , is_dead
var x: int = -1 setget set_x, get_x
var y: int = -1 setget set_y, get_y
var position: Vector2 setget , get_position

var _max_health: int = 0
var _health: int = 0


func _ready() -> void:
	self.dead = false
	self._health = self._max_health


func init(bug_team: int, type: BugType) -> Bug:
	self.team = bug_team
	self.attack_power = type.attack_power
	self.attack_range = type.attack_range
	self.move_range = type.move_range
	self.dead = false
	self._max_health = type.health
	self._health = type.health
	$Body.mesh = type.mesh
	$Body.translation = type.translation
	$Body.rotation_degrees = type.rotation_degrees
	$Body.scale = type.scale
	return self


func attack(bug: Bug) -> void:
	if !dead:
		bug.hit(attack_power)


func hit(power: int) -> void:
	_health -= power
	if _health <= 0:
		_health = 0
		dead = true
		emit_signal("dead")


func get_move_range() -> int:
	return move_range


func get_attack_power() -> int:
	return attack_power


func get_attack_range() -> int:
	return attack_range


func get_team() -> int:
	return team


func is_dead() -> bool:
	return dead


func get_x() -> int:
	return x


func set_x(new_x: int) -> void:
	x = new_x


func get_y() -> int:
	return y


func set_y(new_y: int) -> void:
	y = new_y


func get_position() -> Vector2:
	return Vector2(x, y)


func set_position(new_x: int, new_y: int) -> void:
	x = new_x
	y = new_y
