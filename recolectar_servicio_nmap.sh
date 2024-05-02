#!/bin/bash


####################################
#incluye varias palabras en un mismo grep para la busqueda
#grep -E 'udp|tcp'

#Extrae la ip del objetivo desde el texto
#cut -d'_' -f1

#al grepear extrae el numero del puerto sacando el /tcp o /udp
#aparte esto primero busca las palabras udp y tcp para sacar el contenido que no deseamos
#le corta el / para que no aparezca el tcp udp y saca de la busqueda closed (el final de la linea)
#y el tcpwrapped que simboliza cuando el firewall le da una respuesta no positiva para generar ruido
#grep -E 'udp|tcp' | cut -d'/' -f1 | grep -vE "closed|tcpwrapped"


####################################

# Inicializar variables
servicios=()

# Procesar opciones de la línea de comandos
while getopts ":s:" opt; do
    case $opt in
        s)
            servicios=($(echo "$OPTARG" | tr ',' ' '))
            ;;
        \?)
            echo "Opción inválida: -$OPTARG" >&2
            exit 1
            ;;
    esac
done

# Obtener la lista de archivos .txt en el directorio actual
archivos_txt=$(find . -name "*.txt")

# Bucle a través de cada servicio
for servicio in "${servicios[@]}"; do
    # Convertir el servicio actual en un patrón para grep
    patron_servicio=$(echo "$servicio")

    # Bucle a través de cada archivo .txt
    for archivo in $archivos_txt; do
        # Extraer la dirección IP del nombre del archivo
        ip=$(echo "$archivo" | cut -d'_' -f1)

        # Realizar la búsqueda del servicio actual en el archivo
        servicios_encontrados=$(grep -E 'udp|tcp' "$archivo" | grep "$patron_servicio" | cut -d'/' -f1 | grep -vE "closed|tcpwrapped")

        # Almacenar los resultados antes de entrar al bucle interno
        resultados=()

        # Bucle interno para ir resultado por resultado de lo grepeado
        for servicios_grepeados in $servicios_encontrados; do
            resultados+=("$ip:$servicios_grepeados")
        done

        # Crear el archivo si no existe
        touch "${servicio}.txt"

        # Escribir la lista de resultados en el archivo correspondiente
        printf "%s\n" "${resultados[@]}" | cut -d'/' -f2 >> "${servicio}.txt"
    done
    # Ordenar el archivo resultante
    sort -uo "${servicio}.txt" "${servicio}.txt"
done