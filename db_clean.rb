# coding: utf-8
require 'csv'
require "#{Dir.pwd}/db/data.rb"

Prestamo.destroy!
Puntaje.destroy!
Socio.destroy!
Genero.destroy!
Pelicula.destroy!
