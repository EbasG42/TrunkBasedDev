#!/bin/bash
set -e

IMAGE_NAME="disk-bench"
HOST_DIR="/tmp/bench_host"
VOLUME_NAME="bench_named"

echo "========================================="
echo "Construyendo imagen $IMAGE_NAME..."
docker build -t $IMAGE_NAME .

echo "========================================="
echo "Creando recursos..."
docker volume create $VOLUME_NAME >/dev/null
mkdir -p $HOST_DIR

echo "========================================="
echo "Benchmark con VOLUMEN NOMBRADO"
docker run --rm -v $VOLUME_NAME:/bench $IMAGE_NAME | tee result_named.txt

echo "========================================="
echo "Benchmark con BIND MOUNT"
docker run --rm -v $HOST_DIR:/bench $IMAGE_NAME | tee result_bind.txt

echo "========================================="
echo "Benchmark con TMPFS (RAM)"
docker run --rm --mount type=tmpfs,target=/bench,tmpfs-size=1g disk-bench | tee result_tmpfs.txt



echo "========================================="
echo "RESULTADOS COMPARATIVOS:"
echo "-----------------------------------------"
echo "Volumen nombrado:"
grep -E "copied" result_named.txt
echo "-----------------------------------------"
echo "Bind mount:"
grep -E "copied" result_bind.txt
echo "-----------------------------------------"
echo "Tmpfs:"
grep -E "copied" result_tmpfs.txt
echo "========================================="
echo "Finalizado. Resultados guardados en:"
echo " - result_named.txt"
echo " - result_bind.txt"
echo " - result_tmpfs.txt"
