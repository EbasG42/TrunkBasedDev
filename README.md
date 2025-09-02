Ejercicio 5: Volumenes y rendimiento
<br>
Dentro del script realizado primero se definen variables 
<br>
<img width="287" height="98" alt="image" src="https://github.com/user-attachments/assets/72de36bf-44e5-4326-bed9-76f2638c027d" />
<br>
Despues de construir la imagen de docker y un volumen. 
<br>
<img width="527" height="237" alt="image" src="https://github.com/user-attachments/assets/a0536069-14e6-4b4d-ae12-d7b8996f8a6c" />
<br>
El comando
<br>
docker run --rm -v $VOLUME_NAME:/bench $IMAGE_NAME | tee result_named.txt 
<br>
Monta el volumen dentro del contenedor en /bench, documentandolo en el archivo result_named.txt
<br>
<img width="579" height="211" alt="image" src="https://github.com/user-attachments/assets/8eec7fd2-449d-42bc-af96-160938c9e406" />
<br>
Con el siguiente comando se hace algo parecido a lo anterior, pero se monta una carpeta de host en lugar del volumen de docker
<br>
docker run --rm -v $HOST_DIR:/bench $IMAGE_NAME | tee result_bind.txt
<br>
<img width="585" height="183" alt="image" src="https://github.com/user-attachments/assets/a1d073b4-6d31-4788-b9e7-ee5b38448243" />
<br>
Para Tmpfs, en la teoria, se monta un filesystem en la memoria RAM, sin embargo, buscando la implementacion de Tmpfs en docker, no funcionó y fue la unica prueba que no pudo ser terminada
<br>
docker run --rm --tmpfs /bench:rw,size=1G $IMAGE_NAME | tee result_tmpfs.txt
<br>

<br>
<img width="595" height="213" alt="image" src="https://github.com/user-attachments/assets/96c622fc-641f-4c2c-ae6b-dc3d3b4a1e7c" />
<br>
Ejercicio 2
creacion de redes con el siguiente comando
<br>
docker network create red_a
docker network create red_b
docker network create red_c
<br>
Una vez creadas las redes, procedemos a crear los contenedores con el siguiente comando
<br>
docker run -dit --name alpha --network red_a alpine-ping
docker run -dit --name beta  --network red_b alpine-ping
docker run -dit --name gamma --network red_c alpine-ping
docker run -dit --name delta --network red_a alpine-ping
<br>
Crear contenedor delta que sera nuestro hub de comunicacion
<br>
docker network connect red_b delta
docker network connect red_c delta
<br>
Y por ultimo procedemos a las pruebas de conectividad entre las redes
<br>
# Desde alpha
docker exec -it alpha ping -c 2 delta
docker exec -it alpha ping -c 2 beta    # debe FALLAR
docker exec -it alpha ping -c 2 gamma   # debe FALLAR

# Desde beta
docker exec -it beta ping -c 2 delta
docker exec -it beta ping -c 2 alpha    # debe FALLAR
docker exec -it beta ping -c 2 gamma    # debe FALLAR

# Desde gamma
docker exec -it gamma ping -c 2 delta
docker exec -it gamma ping -c 2 alpha   # debe FALLAR
docker exec -it gamma ping -c 2 beta    # debe FALLAR

# Desde delta
docker exec -it delta ping -c 2 alpha
docker exec -it delta ping -c 2 beta
docker exec -it delta ping -c 2 gamma





