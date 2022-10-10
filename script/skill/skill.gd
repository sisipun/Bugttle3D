class_name Skill
extends Resource


export (Texture) var icon = null


func get_possible_targets(_bug: Bug, _field: Field) -> Array:
	return []


func execute(_bug: Bug, _target: Tile, _field: Field) -> bool:
	return false
