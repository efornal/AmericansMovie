# coding: utf-8
#
# Considera el siguiente orden de encabezado CSV:
# CÓDIGO | TITULO | DURAC. | DIRECTOR | ORIGEN

require 'csv'
require "#{Dir.pwd}/db/data.rb"

CSV_PATH_FILE = "#{Dir.pwd}/db/catalog.csv"
CSV_COL_SEP = '|'
CSV_HEADERS = true


CSV.foreach( CSV_PATH_FILE,
             col_sep: CSV_COL_SEP,
             headers: CSV_HEADERS) do |row|

  p = Hash.new
  # map from csv file
  p['codigo']   = row[0]
  p['titulo']   = row[1]
  p['duracion'] = row[2]
  p['director'] = row[3]
  p['origen']   = row[4]

  
  if pelicula = Pelicula.create(p)
    puts "Created!: #{pelicula.codigo}"
  else
    puts "ERROR!:   #{pelicula.codigo}"
  end
  
end
