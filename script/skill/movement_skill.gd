class_name MovementSkill
extends BaseSkill


func get_targets(bug: Bug, field: Field) -> Array:
	var targets: Array = []
	for tile in field.tiles:
		var path_info: PathInfo = PathFinder.find_path(
			bug.position, 
			tile.position, 
			field, 
			bug.move_range
		)
		if path_info.path != []:
			targets.append(tile)
	return targets


func execute(bug: Bug, target: Tile, field: Field) -> bool:
	if not (target in get_targets(bug, field)):
		return false
	
	var path_info: PathInfo = PathFinder.find_path(
		bug.position, 
		target.position, 
		field, 
		bug.move_range
	)
	field.move_bug(bug, path_info)
	return true
