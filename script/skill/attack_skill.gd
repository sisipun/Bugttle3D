class_name AttackSkill
extends Skill


func get_possible_targets(bug: Bug, field: Field) -> Array:
	var result: Array = []
	for tile in field.tiles:
		var direction = bug.position - tile.position
		var distance = abs(direction.x) + abs(direction.y)
		if (
			tile.has_bug()
			and tile.bug.team != bug.team
			and distance <= bug.attack_range
			and bug.position != tile.position
		):
			result.append(tile)
	return result


func execute(bug: Bug, target: Tile, field: Field) -> bool:
	if not (target in get_possible_targets(bug, field)):
		return false
	
	bug.attack(target.bug)
	return true
