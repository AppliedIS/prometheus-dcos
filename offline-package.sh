#!/bin/bash

cd "$(dirname "$0")"

mkdir delivery 
cd delivery

for IMAGE in `grep \"image\" ../group.json | awk '{print $2}' | cut -d\" -f2`;
do
        FILE_IMAGE_NAME=`echo $IMAGE | cut -d\" -f2 | sed 's^[/:]^-^g'`
	docker pull $IMAGE
        docker save $IMAGE | gzip > $FILE_IMAGE_NAME.tar.gz
done
for ZIP in `grep uri ../group.json | awk '{print $2}' | cut -d\" -f 2`;
do
	wget -k $ZIP
done
