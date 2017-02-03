#!/bin/bash

cd "$(dirname "$0")"

mkdir delivery 
cd delivery

EXTRA="wrouesnel/postgres_exporter:v0.1.1 prom/haproxy-exporter:v0.7.1"
for IMAGE in `grep \"image\" ../group.json | awk '{print $2}' | cut -d\" -f2` $EXTRA;
do
        FILE_IMAGE_NAME=`echo $IMAGE | cut -d\" -f2 | sed 's^[/:]^-^g'`.tar.gz
	docker pull $IMAGE
        echo Saving $FILE_IMAGE_NAME...
        docker save $IMAGE | gzip > $FILE_IMAGE_NAME
done

for ZIP in `grep uri ../group.json | awk '{print $2}' | cut -d\" -f 2`;
do
	wget -k $ZIP
done
