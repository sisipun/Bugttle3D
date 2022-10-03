extends KinematicBody


class_name Bug


signal dead(bug)


export (NodePath) onready var _shape = get_node(_shape) as CollisionShape
export (NodePath) onready var _body = get_node(_body) as MeshInstance


var _max_health: int = 0
var _health: int = 0
var _attack_power: int = 0
var _attack_range: int = 0
var _team: int = Team.RED
var _dead: bool = false


func _ready() -> void:
	self._health = self._max_health
	self._dead = false


func init(team: int, data: BugData) -> Bug:
	self._team = team
	self._max_health = data.health
	self._health = data.health
	self._attack_power = data.attack_power
	self._attack_range = data.attack_range
	self._body.mesh = data.mesh
	self._body.translation = data.translation
	self._body.rotation_degrees = data.rotation_degrees
	self._body.scale = data.scale
	self._dead = false
	return self


func attack(bug: Bug) -> void:
	bug.hit(_attack_power)


func hit(power: int) -> void:
	_health -= power
	if _health <= 0:
		_health = 0
		_dead = true
		emit_signal("dead", self)


func team() -> int:
	return _team


func dead() -> bool:
	return _dead
