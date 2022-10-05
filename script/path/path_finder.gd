class_name PathFinder
extends Node


static func find_path(source: Tile, target: Tile) -> PathInfo:
	var bug: Bug = source.bug
	if !bug:
		return PathInfo.new([])
	
	if source.position.distance_to(target.position) > bug.move_range:
		return PathInfo.new([])
	
	return PathInfo.new([target.position])
