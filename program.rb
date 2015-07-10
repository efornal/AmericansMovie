require_relative 'data.rb'
# this is just for requirement gathering
class Program


# Carga de datos.
  def cargar_socio(hashSocio)
    Socio.create(nombre: hashSocio[:nombre].downcase, apellido: hashSocio[:apellido].downcase, nro_socio: hashSocio[:codigo].to_i)
  end

  def cargar_pelicula(hashPelicula)
    Pelicula.create(titulo: hashPelicula[:titulo].downcase, director: hashPelicula[:director].downcase, origen: hashPelicula[:origen].downcase, duracion: hashPelicula[:duracion].to_i, codigo: hashPelicula[:codigo].to_i, stock: hashPelicula[:cantCopias].to_i)
  end

  def cargar_genero(strGenero)
    Genero.create(nombre: strGenero.downcase)
  end

  def cargar_pelicula(hashPelicula, dbgenero)
    peli = cargar_pelicula(hashPelicula)
    dbgenero.each {|g| peli << g} if dbgenero.class.to_s == "DataMapper::Collection"
    peli << dbgenero if dbgenero.class == Genero
    peli << cargar_genero(dbgenero) if dbgenero.class == String #este puede generar problemas.
    peli.save
  end

# Modificar datos
  def modificar_socio(socio, hashSocio)
    if Socio.include? socio
      socio.nombre = hashSocio[:nombre].downcase
      socio.apellido = hashSocio[:apellido].downcase
      socio.nro_socio = hashSocio[:codigo].to_i
      socio.save
    end
  end

  def modificar_pelicula(pelicula, hashPelicula)
    if Pelicula.include?(pelicula)
      pelicula.titulo = hashPelicula[:titulo].downcase
      pelicula.director = hashPelicula[:director].downcase
      pelicula.origen = hashPelicula[:origen].downcase
      pelicula.codigo = hashPelicula[:codigo].to_i
      pelicula.duracion = hashPelicula[:duracion].to_i
      pelicula.stock = hashPelicula[:stock].to_i
      #ver como modificar los generos asignados.
      pelicula.save
    end
  end

# Acciones
  def realizar_prestamo(socio, dbpelicula)
    if Socio.include? socio
      dbpelicula.each {|p| socio.peliculas << p} if dbpelicula.class.to_s == "DataMapper::Collection"
      socio << dbpelicula if dbpelicula.class == Pelicula
      socio.save
    end
  end

  def devolver_pelicula(socio, pelicula)
    #alguna forma de encontrar las peliculas no devueltas que poseen los socios.
    #encontrar el prestamo asociado a la pelicula que el socio quiere devolver (pelicula no devuelta.)
  end

  def puntuar_pelicula(socio, pelicula, puntuacion)
    if (Pelicula.include?(pelicula) && (Socio.include?(socio)))
      pelicula.puntajes << Puntaje.create(socio_id: socio.id, nro_puntaje: puntuacion.to_i)
      socio.save
      peli.save
    end
  end

  def asignar_genero(pelicula, genero)
    if Pelicula.include?(pelicula) && Genero.include?(genero)
      unless pelicula.generos.include?(genero)
        pelicula << genero
        pelicula.save
      end
    end
  end

# Mostrar datos
  def mostrar_str_generos
    Genero.collect {|g| g.nombre}
  end

  def mostrar_ptj_promedio(pelicula)
    ((pelicula.puntajes.collect{|e| e.nro_puntaje}.inject{|s, i| s + i}).to_f / pelicula.puntajes.size.to_f) if Pelicula.include?(pelicula)
  end


end
