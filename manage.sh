
#! /bin/bash 

WORKDIR="/tmp/blazingpizza"

IMAGE_NAME="blazingpizza"
CONTAINER_NAME="blazingpizza"
HOST_PORT=5000
CONTAINER_PORT=80
REPO_URL="https://github.com/BillyQuispe/BlazzingPizza"

mkdir -p $WORKDIR

git clone $REPO_URL $WORKDIR

cd $WORKDIR

docker build -t "$IMAGE_NAME" .

docker run -d -p $HOST_PORT:$CONTAINER_PORT --name "$CONTAINER_NAME" "$IMAGE_NAME"

sleep 5

rm -rf $WORKDIR

echo "Aplicacion desplegada"