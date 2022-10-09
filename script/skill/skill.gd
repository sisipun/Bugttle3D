class_name Skill
extends Resource


func get_possible_targets(_bug: Bug, _field: Field) -> Array:
	return []


func execute(_bug: Bug, _target: Tile, _field: Field) -> bool:
	return false
