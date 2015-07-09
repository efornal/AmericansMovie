require_relative "data.rb"
DataMapper.auto_migrate!
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

socio = Socio.create(nombre: "Esteban", apellido: "Fornal", nro_socio: 354654)

socio.peliculas << peli
socio.save

# last added on puntaje testing
socio.puntajes << Puntaje.create(nro_puntaje: 10, pelicula_id: peli.id)

socio.save
peli.save


# sqlite3 development.db
# --------------------------
# sqlite> select * from puntajes;
# 1|10|2015-07-09T00:47:18-03:00|1|1
# sqlite> select * from socios;
# 1|Esteban|Fornal|354654
# sqlite> select * from peliculas;
# 1|7 cajas|Maneglia, Juan Carlos & Schembori, Tana|Paraguay, 2012|105|23
