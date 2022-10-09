class_name MovementSkill
extends Skill


func get_possible_targets(bug: Bug, field: Field) -> Array:
	var result = []
	for tile in field.tiles:
		if bug.position.distance_to(tile.position) < bug.move_range:
			result.append(tile)
	return result


func execute(bug: Bug, target: Tile, field: Field) -> bool:
	var source: Tile = field.get_bug_tile(bug)
	if PathFinder.find_path(bug, target).value == []:
		return false
	
	source.remove_bug()
	target.add_bug(bug)
	return true
