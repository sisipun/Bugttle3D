class_name AIController
extends BaseController


export (int) var _turn_delay: int = 1

var _bugs: Array = []
var _timer: Timer = null


func _ready():
	_timer = Timer.new()
	_timer.wait_time = _turn_delay
	add_child(_timer)


func _before_turn() -> void:
	for tile in _field.tiles:
		if (
			tile.has_bug() 
			and tile.bug.team == team
			and not tile.bug.dead
		):
			_bugs.append(tile.bug)
	_turn()


func _turn() -> void:
	_timer.start()
	yield(_timer, "timeout")
	for bug in _bugs:
		for skill in bug.skills:
			var possible_targets = skill.get_possible_targets(bug, _field)
			if possible_targets != []:
				skill.execute(
					bug, 
					possible_targets[randi() % len(possible_targets)], 
					_field
				)
				yield(_timer, "timeout")
	_timer.stop()
	emit_signal("turn_ended")


func _after_turn() -> void:
	_bugs.clear()
