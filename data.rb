require 'dm-core'
require 'dm-migrations'

# If you want the logs displayed you have to do this before the call to setup
DataMapper::Logger.new($stdout, :debug)

DataMapper.setup(:default, "sqlite3://#{Dir.pwd}/development.db")

class Socio
 include DataMapper::Resource #as mixin

 property :id, Serial
 property :nombre, String
 property :apellido, String
 property :nro_socio, Integer


 has n, :prestamos
 has n, :peliculas, :through => :prestamos

end

class Pelicula
 include DataMapper::Resource #as mixin

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
 include DataMapper::Resource #as mixin

 belongs_to :socio,   :key => true
 belongs_to :pelicula, :key => true
end

DataMapper.finalize
