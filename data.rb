require 'dm-core'
require 'dm-migrations'

DataMapper.setup(:default, "sqlite3://#{Dir.pwd}/development.db")

class Socio
 include DataMapper::Resource

 property :id, Serial
 property :nombre, String
 property :apellido, String
 property :nro_socio, Integer


 has n, :prestamos
 has n, :peliculas, :through => :prestamos

end

class Pelicula
 include DataMapper::Resource

 property :id, Serial
 property :titulo, String
 property :director, String
 property :origen, String
 property :duracion, Integer
 property :codigo, Integer

 has n, :prestamos
 has n, :socios, :through => :prestamos
end

class Prestamo
 include DataMapper::Resource

 belongs_to :socio,   :key => true
 belongs_to :pelicula, :key => true
end

DataMapper.finalize
