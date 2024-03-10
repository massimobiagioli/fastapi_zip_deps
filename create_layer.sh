#!/bin/bash

DIRECTORY="$(pwd)"
LAYER_NAME="layer"

poetry export -f requirements.txt --output requirements.txt --without-hashes

docker build -t lambda-layer "$DIRECTORY"
docker run --name lambda-layer-container -v "$DIRECTORY:/app" lambda-layer

mkdir -p layers

mv "$DIRECTORY/$LAYER_NAME.zip" "$DIRECTORY/layers/$LAYER_NAME.zip"

docker stop lambda-layer-container
docker rm lambda-layer-container
docker rmi --force lambda-layer