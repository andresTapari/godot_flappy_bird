extends Node

class_name FileSystem

# Función para guardar:
func saveToFile(data: Array, score_file:String = "user://score.save") -> void:
	# Creamos la instancia file
	var file = File.new()
	# Abrimos el archivo en modo escritura
	file.open(score_file, File.WRITE)
	# Almacenamos los datos
	file.store_var(data, true)
	# Cerramos el archivo
	file.close()

# Función para cargar:
func loadFromFile(score_file:String = "user://score.save") -> Array:
	# Creamos la instancia file
	var file = File.new()
	# Creamos lista vacia donde guardamos los datos
	var data: Array = []
	# Si el archivo existe:
	if file.file_exists(score_file):
		# Abrimos el archivo en modo lectura
		file.open(score_file, File.READ)
		# Obtenemos los datos
		data = file.get_var(true)
		# Cerramos el archivo
		file.close()
	# Devolvemos los datos
	return data


