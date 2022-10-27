@tool
extends MeshInstance3D


func _ready() -> void:
	var mesh_data =[]
	mesh_data.resize(Mesh.ARRAY_MAX) #modifica a lista para comportar os dados necessario para uma ArrayMesh
	
	var rotation_range = 10.0
	
	var vertices = PackedVector3Array()
	var array_index = PackedInt32Array()
	
	var x_coords_base = generate_points(0,9,20)
	var y_coords_base = generate_y_coords(x_coords_base)
	
	
	for theta in range(0.0,360.0,rotation_range):
		for x in range(0,len(x_coords_base)):
			var point_to_add = Vector3(x_coords_base[x]*cos(deg_to_rad(theta)), y_coords_base[x], x_coords_base[x]*sin(deg_to_rad(theta)))
			if not vertices.has(point_to_add):
				vertices.push_back(point_to_add)
	
	mesh_data[Mesh.ARRAY_VERTEX] = vertices
	
	#envelope de base
	var index = 1
	var neighbor = len(x_coords_base)
	var shift = neighbor - 1
	
	var turns = 360.0/rotation_range
	var counter = 1
	
	while counter <= turns:
		if counter < turns:
			array_index.push_back(index)
			array_index.push_back(0)
			array_index.push_back(neighbor + (counter-1)*shift)
			
			#[workaround]
			array_index.push_back(neighbor + (counter-1)*shift)
			array_index.push_back(0)
			array_index.push_back(index)
			
			index = neighbor + (counter-1)*shift
			counter +=1
		else:
			array_index.push_back(0)
			array_index.push_back(index)
			array_index.push_back(1)
			
			#[workaround]
			array_index.push_back(1)
			array_index.push_back(index)
			array_index.push_back(0)
			counter +=1
	
	#envelope de corpo
	for i in range(1,len(x_coords_base)+1):
		if i == 1:
			array_index.append_array(wrap_up(i,turns,shift))

		else:
			if i < len(x_coords_base)-1:
				array_index.append_array(wrap_down(i,turns,shift))

				array_index.append_array(wrap_up(i,turns,shift))

			elif i == len(x_coords_base)-1:
				array_index.append_array(wrap_down(i,turns,shift))

	
	mesh_data[Mesh.ARRAY_INDEX] = array_index
	
	mesh = ArrayMesh.new()
	mesh.add_surface_from_arrays(Mesh.PRIMITIVE_TRIANGLES,mesh_data)

func wrap_up(start_point,rounds,shift_mesh):
	var counter = 1
	var current_index = start_point
	var list = []
	while counter <= rounds:
		if counter < rounds:
			list.push_back(current_index)
			list.push_back(current_index+(shift_mesh))
			list.push_back(current_index+(shift_mesh)+1)
			
			#[workaround]
			list.push_back(current_index+(shift_mesh)+1)
			list.push_back(current_index+(shift_mesh))
			list.push_back(current_index)
			
			current_index += shift_mesh
			counter+=1
		else:
			list.push_back(current_index)
			list.push_back(start_point)
			list.push_back(start_point+1)
			
			#[workaround]
			list.push_back(start_point+1)
			list.push_back(start_point)
			list.push_back(current_index)
			counter+=1
	
	return list


func wrap_down(start_point,rounds,shift_mesh):
	var counter = 1
	var current_index = start_point
	var list = []
	while counter <= rounds:
		if counter < rounds:
			list.push_back(current_index)
			list.push_back(current_index-1)
			list.push_back(current_index+(shift_mesh))
			
			#[workaround]
			list.push_back(current_index+(shift_mesh))
			list.push_back(current_index-1)
			list.push_back(current_index)
			
			current_index += shift_mesh
			counter+=1
		else:
			list.push_back(current_index)
			list.push_back(current_index-1)
			list.push_back(start_point)
			
			#[workaround]
			list.push_back(start_point)
			list.push_back(current_index-1)
			list.push_back(current_index)
			counter+=1
	
	return list




func generate_y_coords(x):
	var array = []
	for i in x:
		if i < 5.75:
			array.append(pow(i,4)/100)
		else:
			array.append(-i**2 + 12*i - 25)
	return array


#retorna uma lista de numeros incluindo os valores minimos com uma quantidade de pontos ao meio igualmente espaçados
func generate_points(min_value:float, max_value:float, middle_points:float):
	var middle_points_array = []
	var middle_points_real =middle_points+1
	
	middle_points_array.append(float(min_value))
	
	for i in range(1,middle_points_real):
		middle_points_array.append(float(min_value+(i*((max_value-min_value)/middle_points_real))))
	
	middle_points_array.append(float(max_value))
	
	return(middle_points_array)


func numbers_on_space(list):
	for i in range(0,len(list)):
		var label = Label3D.new()
		label.name = "x:"+str(list[i].x)+" y:"+str(list[i].y)+" z:"+str(list[i].z)
		label.text = str(i)+"->x:"+str(list[i].x)+" y:"+str(list[i].y)+" z:"+str(list[i].z)
		label.position = list[i]
		$"../Node3D".add_child(label)
