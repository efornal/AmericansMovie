require 'dm-core'
require 'dm-migrations'
require 'dm-timestamps' #provides automatic updates of created_at or created_on and updated_at or updated_on properties for your resources.



DataMapper::Logger.new($stdout, :debug) # If you want the logs displayed; verbose mode.

DataMapper.setup(:default, "sqlite3://#{Dir.pwd}/development.db")

class Socio
 include DataMapper::Resource #as mixin

 property :id, Serial
 property :nombre, String
 property :apellido, String
 property :nro_socio, Integer, required: true


 has n, :prestamos
 has n, :puntajes #?
 has n, :peliculas, :through => :prestamos #and :puntajes

end

class Pelicula
 include DataMapper::Resource #as mixin

 property :id, Serial
 property :titulo, String, required: true
 property :director, String
 property :origen, String
 property :duracion, Integer
 property :codigo, Integer, required: true

 has n, :prestamos
 #has n, :generos
 has n, :puntajes #?
 has n, :socios, :through => :prestamos

end

class Prestamo
 include DataMapper::Resource #as mixin

 property :updated_at, DateTime

 belongs_to :socio,   :key => true
 belongs_to :pelicula, :key => true
end

class Genero
  include DataMapper::Resource #as mixin

  property :id, Serial
  property :nombre, String, required: true

  #has n, :peliculas
end

class Puntaje
  include DataMapper::Resource

  property :id, Serial
  property :nro_puntaje, Integer, required: true
  property :updated_at, DateTime

  belongs_to :socio,   :key => true
  belongs_to :pelicula, :key => true
end

DataMapper.finalize
