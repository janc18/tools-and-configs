#!/bin/bash
# Directorio que contiene las imágenes originales
input_directory="."

# Directorio de salida para las imágenes recortadas
output_directory="./cropped_images"

# Verificar si exiten archivos png
ls *.png 2> /dev/null
if [ $? = 2 ]; then
  echo "I can't find any images"
  exit
fi

mkdir -p $output_directory
# Tamaño y posición del recorte (ajústalos según tus necesidades)
crop_dimensions="1500x900+300+60"
# Bucle para procesar todas las imágenes en el directorio de entrada
for file in "$input_directory"/*.png; do
    # Obtén el nombre del archivo sin la ruta
    filename=$(basename -- "$file")
    convert "$file" -fuzz 30% -transparent blue ${filename}_clean.png
    # Realiza el recorte y guarda la imagen en el directorio de salida
    convert ${filename}_clean.png -crop "$crop_dimensions" "$output_directory/cropped_$filename"
done

rm *_clean.png
