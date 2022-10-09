class_name BugType
extends Resource


export(int) var health = 3
export(int) var move_range = 2
export(int) var attack_power = 1
export(int) var attack_range = 1
export(Mesh) var mesh = null
export(Vector3) var translation = Vector3.ZERO
export(Vector3) var rotation_degrees = Vector3.ZERO
export(Vector3) var scale = Vector3.ONE
export(Array, Resource) var skills = []
