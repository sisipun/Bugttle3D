class_name AttackSkill
extends Skill


func get_possible_targets(bug: Bug, field: Field) -> Array:
	var result: Array = []
	for tile in field.tiles:
		var direction = bug.position - tile.position
		var distance = abs(direction.x) + abs(direction.y)
		if (
			distance <= bug.attack_range
			and bug.position != tile.position
		):
			result.append(tile)
	return result


func execute(bug: Bug, target: Tile, field: Field) -> bool:
	var target_bug: Bug = target.bug
	if (
		not (target in get_possible_targets(bug, field))
		or !target_bug 
		or target_bug.team == bug.team
	):
		return false
	
	bug.attack(target_bug)
	return true
