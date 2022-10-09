class_name PathFinder
extends Node


static func find_path(bug: Bug, target: Tile) -> PathInfo:
	if bug.position.distance_to(target.position) > bug.move_range:
		return PathInfo.new([])
	
	return PathInfo.new([target.position])
