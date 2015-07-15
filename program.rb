require_relative 'db/data.rb'
# this is just for requirement gathering
module Program


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
      #faltaria hacer los descuentos de stock pertinentes
      socio.save
    end
  end

  def devolver_pelicula(socio, pelicula)

    aux = ((socio.prestamos.select{|p| p.devolucion == nil}).select{|p| p.pelicula_id == pelicula.id}).first
    aux.devolucion = DateTime.now
    aux.save #Esto asume que todo esta ok, que la pelicula esta prestada al socio y nadie se olvido de cargar el prestamo.

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

  def mostrar_pelicula_popular_semana
    #Pelicula.prestamos.select{|pr| }
    #Need to compare between two DateTime data, to get time laps.
  end
end
