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
	
	field.get_tile(path_info.path[0]).remove_bug()
	field.get_tile(path_info.path[-1]).set_bug(bug)
	bug.move_range -= path_info.cost
	return true
