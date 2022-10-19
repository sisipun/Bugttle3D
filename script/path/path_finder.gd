class_name PathFinder
extends Node


class PriorityPoint:
	var position: Vector2
	var priority: int
	
	func _init(_position: Vector2, _priority: int) -> void:
		self.position = _position
		self.priority = _priority
	
	
	static func sort(p1: PriorityPoint, p2: PriorityPoint) -> bool:
		return p1.priority < p2.priority


static func find_path(
	source: Vector2,
	target: Vector2,
	field: Field,
	max_cost: int
) -> PathInfo:
	if source == target or max_cost == 0:
		return PathInfo.new([], 0)
	
	var paths: Dictionary = {}
	var costs: Dictionary = {source: 0}
	var points: Array = [PriorityPoint.new(source, 0)]
	
	while not points.empty():
		points.sort_custom(PriorityPoint, "sort")
		var priority_point: PriorityPoint = points[0]
		points.remove(0)
		
		var point: Vector2 = priority_point.position
		var neighbors: Array = _find_neighbors(point, field)
		
		for neighbor in neighbors:
			var neighbor_tile: Tile = field.get_tile(neighbor)
			var neighbor_cost: int = neighbor_tile.cost
			var neighbor_path_cost: int = neighbor_cost + costs[point]
			if (
				!neighbor_tile.has_bug()
				and neighbor_cost >= 0
				and neighbor_path_cost <= max_cost
				and (
					not (neighbor in costs) 
					or costs[neighbor] > neighbor_path_cost
				)
			):
				costs[neighbor] = neighbor_path_cost
				paths[neighbor] = point
				points.append(PriorityPoint.new(
					neighbor, 
					neighbor_path_cost + _distance(neighbor, target)
				))
	
	return _get_shortest_path(paths, costs, source, target)


static func _find_neighbors(position: Vector2, field: Field) -> Array:
	var neighbors = []
	if position.x > 0:
		neighbors.append(Vector2(position.x - 1, position.y))
	if position.y > 0:
		neighbors.append(Vector2(position.x, position.y - 1))
	if position.x < field.width - 1:
		neighbors.append(Vector2(position.x + 1, position.y))
	if position.y < field.height - 1:
		neighbors.append(Vector2(position.x, position.y + 1))
	return neighbors


static func _distance(source: Vector2, target: Vector2) -> int:
	return int(abs(source.x - target.x) + abs(source.y - target.y))


static func _get_shortest_path(
	paths: Dictionary,
	costs: Dictionary,
	source: Vector2,
	target: Vector2
) -> PathInfo:
	var current: Vector2 = target
	var shortest_path: Array = [current]
	while(current != source):
		if not(current in paths):
			return PathInfo.new([], 0)
		current = paths[current]
		shortest_path.append(current)
	
	shortest_path.invert()
	return PathInfo.new(shortest_path, costs[target])
