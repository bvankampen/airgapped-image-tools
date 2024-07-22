IMAGE_LIST=${1-images.txt}

IMAGES=$(cat $IMAGE_LIST)

ARCHIVE=$2
PLATFORM=${3-linux/amd64}

mkdir -p archives
rm -f $ARCHIVE.tar.gz

for IMAGE in $IMAGES; do
  echo "Downloading $IMAGE"
    docker pull --platform $PLATFORM $IMAGE
    docker save $IMAGE | gzip --stdout > archives/$ARCHIVE.tar.gz
done
