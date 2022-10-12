class_name AttackSkill
extends Skill


func get_possible_targets(bug: Bug, field: Field) -> Array:
	var result: Array = []
	for tile in field.tiles:
		if (
			bug.position.distance_to(tile.position) < bug.attack_range
			and bug.position != tile.position
		):
			result.append(tile)
	return result


func execute(bug: Bug, target: Tile, _field: Field) -> bool:
	var target_bug: Bug = target.bug
	if !target_bug or target_bug.team == bug.team:
		return false
	
	bug.attack(target_bug)
	return true
