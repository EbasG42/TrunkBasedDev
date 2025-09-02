Ejercicio 5: Volumenes y rendimiento

Dentro del script realizado primero se definen variables 
<img width="287" height="98" alt="image" src="https://github.com/user-attachments/assets/72de36bf-44e5-4326-bed9-76f2638c027d" />
Despues de construir la imagen de docker y un volumen. 
<img width="527" height="237" alt="image" src="https://github.com/user-attachments/assets/a0536069-14e6-4b4d-ae12-d7b8996f8a6c" />
El comando 
docker run --rm -v $VOLUME_NAME:/bench $IMAGE_NAME | tee result_named.txt 
Monta el volumen dentro del contenedor en /bench, documentandolo en el archivo result_named.txt
<img width="579" height="211" alt="image" src="https://github.com/user-attachments/assets/8eec7fd2-449d-42bc-af96-160938c9e406" />
Con el siguiente comando se hace algo parecido a lo anterior, pero se monta una carpeta de host en lugar del volumen de docker
docker run --rm -v $HOST_DIR:/bench $IMAGE_NAME | tee result_bind.txt
<img width="585" height="183" alt="image" src="https://github.com/user-attachments/assets/a1d073b4-6d31-4788-b9e7-ee5b38448243" />
Para Tmpfs, en la teoria, se monta un filesystem en la memoria RAM, sin embargo, buscando la implementacion de Tmpfs en docker, no funcionó y fue la unica prueba que no pudo ser terminada 
docker run --rm --tmpfs /bench:rw,size=1G $IMAGE_NAME | tee result_tmpfs.txt
<img width="595" height="213" alt="image" src="https://github.com/user-attachments/assets/96c622fc-641f-4c2c-ae6b-dc3d3b4a1e7c" />




