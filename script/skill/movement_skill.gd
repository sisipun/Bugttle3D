class_name MovementSkill
extends Skill


func get_possible_targets(bug: Bug, field: Field) -> Array:
	var result: Array = []
	for tile in field.tiles:
		if (
			bug.position.distance_to(tile.position) < bug.move_range
			and bug.position != tile.position
		):
			result.append(tile)
	return result


func execute(bug: Bug, target: Tile, field: Field) -> bool:
	if target.bug or PathFinder.find_path(bug, target).value == []:
		return false
	
	var source: Tile = field.get_bug_tile(bug)
	source.remove_bug()
	target.add_bug(bug)
	return true
