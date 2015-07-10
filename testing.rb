require_relative "data.rb"
DataMapper.auto_migrate!
#Socio.auto_migrate!
#Pelicula.auto_migrate!
#Prestamo.auto_migrate!

#faltaría testear eliminar asociaciones como: genero - pelicula.

peli1 = Pelicula.create(titulo: "7 cajas", director: "Maneglia, Juan Carlos & Schembori, Tana", origen: "Paraguay, 2012", duracion: 105, codigo: 23)
peli2 = Pelicula.create(titulo: "Matrix", director: "Andy Wachowski & Lana Wachowski", origen: "Estados Unidos, 1999", duracion: 136, codigo: 549)
socio1 = Socio.create(nombre: "Esteban", apellido: "Fornal", nro_socio: 354654)
socio2 = Socio.create(nombre: "Ramiro", apellido: "Flappo", nro_socio: 54654)

socio1.peliculas << peli1 #chaco alquilo 7 cajas
socio2.peliculas << peli2 #yo alquilo matrix
socio2.peliculas << peli1 #tambien alquilo 7 cajas
socio1.save

#modificando valores
socio2.nombre = "Jose"
socio2.save

# last added on puntaje testing
peli1.puntajes << Puntaje.create(nro_puntaje: 8, socio_id: socio1.id) #because it's a movie driven software.
peli1.puntajes << Puntaje.create(nro_puntaje: 7, socio_id: socio2.id)
peli2.puntajes << Puntaje.create(nro_puntaje: 9, socio_id: socio2.id)

drama = Genero.create(nombre: "Drama")
suspenso = Genero.create(nombre: "Suspenso")
accion = Genero.create(nombre: "Accion")
ci_fi = Genero.create(nombre: "Ciencia Ficcion")

peli1.generos << drama
peli1.generos << suspenso
peli2.generos << accion
peli2.generos << ci_fi
peli2.generos << suspenso

socio1.save
socio2.save
peli1.save
peli2.save

# puts socio.puntajes.first.nro_puntaje #>> 10
# sqlite3 development.db
# --------------------------
# sqlite> .tables
# genero_peliculas  peliculas         puntajes
# generos           prestamos         socios
# sqlite> select * from peliculas;
# 1|7 cajas|Maneglia, Juan Carlos & Schembori, Tana|Paraguay, 2012|105|23
# 2|Matrix|Andy Wachowski & Lana Wachowski|Estados Unidos, 1999|136|549
# sqlite> select * from socios;
# 1|Esteban|Fornal|354654
# 2|Ramiro|Flappo|54654
# sqlite> select * from prestamos;
# 2015-07-09T19:01:45-03:00|1|1
# 2015-07-09T19:01:47-03:00|2|2
# sqlite> select * from generos;
# 1|Drama
# 2|Suspenso
# 3|Accion
# 4|Ciencia Ficcion
# sqlite> select * from genero_peliculas;
# 1|1
# 1|2
# 2|3
# 2|4
# 2|2
# sqlite> select * from puntajes;
# 1|8|2015-07-09T19:01:46-03:00|1|1
# 2|9|2015-07-09T19:01:47-03:00|2|2



# Zoo.first(:name => 'Metro')    # first matching record with the name 'Metro'
