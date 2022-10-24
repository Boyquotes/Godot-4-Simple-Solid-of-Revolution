@tool
extends MeshInstance3D

func _ready() -> void:
	var mesh_data =[]
	mesh_data.resize(ArrayMesh.ARRAY_MAX) #modifica a lista para comportar os dados necessario para uma ArrayMesh
	
	var array_points = []
	var x_coords = generate_points(-10,10,2000)

	for i in range(0,len(x_coords)):
		array_points.append(Vector3(x_coords[i],(x_coords[i]**4)/((x_coords[i]**3)-7),0))
	
	
	mesh_data[ArrayMesh.ARRAY_VERTEX] = PackedVector3Array(array_points)
	
	
	var array_index =[]
	
	for i in range(0,len(mesh_data[ArrayMesh.ARRAY_VERTEX])):
		if i < len(mesh_data[ArrayMesh.ARRAY_VERTEX])-1:
			array_index.append(i)
			array_index.append(i+1)
	
	
	mesh_data[ArrayMesh.ARRAY_INDEX] = PackedInt32Array(array_index)
	
	mesh = ArrayMesh.new()
	mesh.add_surface_from_arrays(Mesh.PRIMITIVE_LINES,mesh_data)


#retorna uma lista de numeros incluindo os valores minimos com uma quantidade de pontos ao meio igualmente espaçados
func generate_points(min_value:float, max_value:float, middle_points:float):
	var middle_points_array = []
	
	middle_points_array.append(float(min_value))
	
	for i in range(1,middle_points):
		middle_points_array.append(float(min_value+(i*((max_value-min_value)/middle_points))))
	
	middle_points_array.append(float(max_value))
	
	return(middle_points_array)



