#!/usr/bin/bash

sudo apt-get update
sudo apt-get install awscli ffmpeg python-is-python3
sudo curl -L https://yt-dl.org/downloads/latest/youtube-dl -o /usr/local/bin/youtube-dl
sudo chmod a+rx /usr/local/bin/youtube-dl
