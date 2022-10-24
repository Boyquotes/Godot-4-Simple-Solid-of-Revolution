@tool
extends MeshInstance3D


func _ready():
	var mesh_data =[]
	mesh_data.resize(ArrayMesh.ARRAY_MAX) #modifica a lista para comportar os dados necessario para uma ArrayMesh
	
	mesh_data[ArrayMesh.ARRAY_VERTEX] = PackedVector3Array(
		[
		Vector3(0,0,0),
		Vector3(1,0,0),
		Vector3(1,1,0),
		Vector3(0,1,0),
		]
	)
	var array_index =[]
	
	for i in range(0,4):
		array_index.append(i)
		array_index.append(i+1)
	
	
	mesh_data[ArrayMesh.ARRAY_INDEX] = PackedInt32Array(array_index)
	
	mesh = ArrayMesh.new()
	mesh.add_surface_from_arrays(Mesh.primiti,mesh_data)
