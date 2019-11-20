# Set vars
DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
DATA_DIR="$HOME"
CONTAINER_NAME="cuda_lu_pytorch"

# Stop and remove the existing container if
# it is already running.
docker kill $CONTAINER_NAME
docker rm $CONTAINER_NAME

docker run \
--runtime=nvidia \
--name $CONTAINER_NAME \
-p 8888:8888 \
-v $DATA_DIR:/home\
--privileged=true \
-it $CONTAINER_NAME \
bash
