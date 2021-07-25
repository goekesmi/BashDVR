#!/usr/bin/bash

find . -maxdepth 1 -type d -print0 | xargs -0 -I{} screen -t {} ./startWatcher.sh {}


