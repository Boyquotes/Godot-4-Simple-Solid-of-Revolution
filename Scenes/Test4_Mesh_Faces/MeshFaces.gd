@tool
extends MeshInstance3D


func _ready() -> void:
	var mesh_data =[]
	mesh_data.resize(Mesh.ARRAY_MAX) #modifica a lista para comportar os dados necessario para uma ArrayMesh
	
	var rotation_range = 90.0
	
	var vertices = PackedVector3Array()
	var array_index = PackedInt32Array()
	
	var x_coords_base = generate_points(0,5,2)
	var y_coords_base = generate_y_coords(x_coords_base)
	
	
	for theta in range(0.0,360.0,rotation_range):
		for x in range(0,len(x_coords_base)):
			var point_to_add = Vector3(x_coords_base[x]*cos(deg_to_rad(theta)), y_coords_base[x], x_coords_base[x]*sin(deg_to_rad(theta)))
			if not vertices.has(point_to_add):
				vertices.push_back(point_to_add)
	
	mesh_data[Mesh.ARRAY_VERTEX] = vertices
	
	#envelope de base
	var interactions = len(range(0.0,360.0,rotation_range))
	var index = 1
	var interact = 0
	for i in range(0,interactions):
		interact += 1
		if interact < interactions:
			array_index.push_back(0)
			array_index.push_back(index)
			array_index.push_back(index+2)
			index += 2
		else:
			array_index.push_back(0)
			array_index.push_back(1)
			array_index.push_back(index)
	
	
	
	
	
	
	
	
	
	mesh_data[Mesh.ARRAY_INDEX] = array_index
	
	mesh = ArrayMesh.new()
	mesh.add_surface_from_arrays(Mesh.PRIMITIVE_TRIANGLES,mesh_data)

func generate_y_coords(x):
	var array = []
	for i in x:
		array.append(pow(i,2))
	return array





#retorna uma lista de numeros incluindo os valores minimos com uma quantidade de pontos ao meio igualmente espaçados
func generate_points(min_value:float, max_value:float, middle_points:float):
	var middle_points_array = []
	
	middle_points_array.append(float(min_value))
	
	for i in range(1,middle_points):
		middle_points_array.append(float(min_value+(i*((max_value-min_value)/middle_points))))
	
	middle_points_array.append(float(max_value))
	
	return(middle_points_array)


