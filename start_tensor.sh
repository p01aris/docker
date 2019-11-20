# Set vars
DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
DATA_DIR="$HOME/ghost_volume"
CONTAINER_NAME="ghost_blog"

# Stop and remove the existing container if
# it is already running.
docker kill $CONTAINER_NAME
docker rm $CONTAINER_NAME

docker run \
-d \
--restart=always \
-p 127.0.0.1:2368:2368 \
-v $DATA_DIR/content:/var/lib/ghost/content \
-v $DATA_DIR/config.json:/var/lib/ghost/config.production.json \
--name $CONTAINER_NAME \
bash
