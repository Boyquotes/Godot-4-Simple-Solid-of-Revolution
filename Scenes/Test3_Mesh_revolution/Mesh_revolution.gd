@tool
extends MeshInstance3D


func _ready() -> void:
	var mesh_data =[]
	mesh_data.resize(ArrayMesh.ARRAY_MAX) #modifica a lista para comportar os dados necessario para uma ArrayMesh
	
	var rotation_range = 10.0
	
	var array_points = []
	var x_coords_base = generate_points(0,10,5)
	
	for theta in range(0.0,360.0,rotation_range):
		for x in x_coords_base:
			var point_to_add = Vector3(x*cos(deg_to_rad(theta)), pow(x,2)/10, x*sin(deg_to_rad(theta)))
			if not array_points.has(point_to_add):
				array_points.append(point_to_add)
	mesh_data[ArrayMesh.ARRAY_VERTEX] = PackedVector3Array(array_points)
	
	
	var array_index =[]
	var index = 0
	
	for theta in range(0,360,rotation_range):
		index+=1
		for x in range(0,len(x_coords_base)-1):
			if x == 0.0:
				array_index.append(0)
				array_index.append(index)
			else:
				array_index.append(index)
				array_index.append(index+1)
				index +=1
	
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


