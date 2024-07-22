#!/bin/bash
#
# Get Images in Helm Charts
#

HELM_TMP_DIR=helm
HELM_CHART=$1
OUTPUT_FOLDER=files
IMAGES_LIST=${2-images.txt}
VERSION=${3-latest}

mkdir -p $HELM_TMP_DIR
mkdir -p $OUTPUT_FOLDER

if [[ $VERSION == "latest" ]]; then
  echo "-- Downloading helm chart: $HELM_CHART"
  helm fetch $HELM_CHART -d $HELM_TMP_DIR
else
  echo "-- Downloading helm chart: $HELM_CHART version:$VERSION"
  helm fetch $HELM_CHART -d $HELM_TMP_DIR --version $VERSION
fi

HELM_TGZ=$(ls $HELM_TMP_DIR/*.tgz)

echo "-- Reading helmchart: $HELM_TGZ"

IMAGES=$(helm template chart $HELM_TGZ | awk '$1 ~ /image:/ {print $2}' | sed -e 's/\"//g' | sed -e "s/'//g")

echo "-- Save list to file: $OUTPUT_FOLDER/$IMAGES_LIST"
rm -f $OUTPUT_FOLDER/$IMAGES_LIST
touch $OUTPUT_FOLDER/$IMAGES_LIST
for IMAGE in $IMAGES; do
  echo "   $IMAGE"
  echo $IMAGE >> $OUTPUT_FOLDER/$IMAGES_LIST
done

rm -rf $HELM_TMP_DIR
