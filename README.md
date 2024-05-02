# Nmap_recolector_servicios

El proposito de este script es recolectar todos los nmap que tengas en la carpeta actual y separar una lista de objetivos sobre un servicio que todos tengan, en el ejemplo de abajo vemos que va a hacer una lista de IP:Puerto con todos los objetivos que contengan servicios web http o https, esto sirve para agilizar el realizaxr una lista de objetivos para una ejecución puntual.

En este caso si recolecto todos los objetivos con http puedo tener una lista de manera rapida para realizar un escaneo web masivo a todos los objetivos.

###los nmap tienen que estar separados por objetivos, recomiendo utilizar el massnmap de mi cuenta para que separe bien los datos###

Ejecucion:
./recolectar_servicio_nmap.sh -s http
