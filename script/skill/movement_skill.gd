class_name MovementSkill
extends Skill


func get_possible_targets(bug: Bug, field: Field) -> Array:
	var result: Array = []
	for tile in field.tiles:
		var path_info: PathInfo = PathFinder.find_path(
			bug.position, 
			tile.position, 
			field, 
			bug.move_range
		)
		if path_info.path != []:
			result.append(tile)
	return result


func execute(bug: Bug, target: Tile, field: Field) -> bool:
	if not (target in get_possible_targets(bug, field)):
		return false
	
	var path_info: PathInfo = PathFinder.find_path(
		bug.position, 
		target.position, 
		field, 
		bug.move_range
	)
	field.move_bug(bug, path_info)
	return true
