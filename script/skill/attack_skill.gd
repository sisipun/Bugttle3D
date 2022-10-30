class_name AttackSkill
extends BaseSkill


func get_area(bug: Bug, field: Field) -> Array:
	var area: Array = []
	for tile in field.tiles:
		var direction = bug.position - tile.position
		var distance = abs(direction.x) + abs(direction.y)
		if distance <= bug.attack_range and bug.position != tile.position:
			area.append(tile)
	return area


func get_targets(bug: Bug, field: Field) -> Array:
	var targets: Array = []
	var area: Array = get_area(bug, field)
	for tile in area:
		if tile.has_bug() and tile.bug.team != bug.team:
			targets.append(tile)
	return targets


func execute(bug: Bug, target: Tile, field: Field) -> bool:
	if not (target in get_targets(bug, field)):
		return false
	
	bug.attack(target.bug)
	return true
