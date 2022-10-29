class_name Skill
extends Resource


export (Texture) var icon = null
export (SpatialMaterial) var target_tile_material = null


func get_possible_targets(_bug: Bug, _field: Field) -> Array:
	return []


func execute(_bug: Bug, _target: Tile, _field: Field) -> bool:
	return false
