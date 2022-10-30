class_name BaseSkill
extends Resource


export (Texture) var icon = null
export (SpatialMaterial) var target_material = null
export (SpatialMaterial) var area_material = null


func get_area(_bug: Bug, _field: Field) -> Array:
	return []


func get_targets(_bug: Bug, _field: Field) -> Array:
	return []


func execute(_bug: Bug, _target: Tile, _field: Field) -> bool:
	return false
