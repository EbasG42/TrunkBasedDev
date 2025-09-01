#!/bin/bash
# Ejercicio 2 - Comunicación entre contenedores en diferentes redes

# Crear redes
docker network create red_a
docker network create red_b
docker network create red_c

# Crear contenedores
docker run -dit --name alpha --network red_a alpine sh
docker run -dit --name beta  --network red_b alpine sh
docker run -dit --name gamma --network red_c alpine sh
docker run -dit --name delta --network red_a alpine sh

# Conectar delta a las otras redes
docker network connect red_b delta
docker network connect red_c delta

echo "✅ Ejercicio 2 montado correctamente."
echo "Contenedores en ejecución:"
docker ps
