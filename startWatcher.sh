#!/bin/bash
BUCKETBASE=s3://dc-spekops/DVR

if [ $# -eq 0 ]; then
	echo "No arguments supplied. Expecting run data directory."
	exit 1;
fi

if [ ! -d $1 ]; then
	echo "directory passed as first argument does not exist.  Ending.";
	exit 1;
fi;

cd $1;

while true; do 
	if [ ! -f URL ]; then
		echo "No URL file found.  Ending.";
		exit 1;
	fi;
	URL=`cat URL`
	youtube-dl --external-downloader-args '-loglevel error -stats'  $URL
	CHANNEL=${PWD##*/}
	find . -type f -iname '*.mp4' -print0 | xargs -0 -P3 -I{} aws s3 mv {} $BUCKETBASE/$CHANNEL/ 
	find . -type f -iname '*.mkv' -print0 | xargs -0 -P3 -I{} aws s3 mv {} $BUCKETBASE/$CHANNEL/ 
	sleep 40;
done;
