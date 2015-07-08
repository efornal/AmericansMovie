#Socio.auto_migrate!
#Pelicula.auto_migrate!
#Prestamo.auto_migrate!

peli = Pelicula.create()
peli.titulo = "7 cajas"
peli.director = "Maneglia, Juan Carlos & Schembori, Tana"
peli.origen = "Paraguay, 2012"
peli.duracion = 105
peli.codigo = 23

peli.save
