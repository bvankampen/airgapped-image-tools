IMAGE_LIST=${1-images.txt}

IMAGES=$(cat $IMAGE_LIST)

REGISTRY=$2
PROJECT=$3

skopeo login $REGISTRY

for IMAGE in $IMAGES; do
  echo "Downloading $IMAGE"
  skopeo copy --all --src-no-creds docker://$IMAGE docker://$REGISTRY/$IMAGE
done
