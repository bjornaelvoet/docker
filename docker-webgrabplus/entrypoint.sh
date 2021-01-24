#!/bin/sh

cd /app/wg++/bin/

# Every 8 hour means 60 * 60 * 8 = 28800 secs
# Or just run and kill the docker process once finished
while true
do
  echo "Executing..."
  mono WebGrab+Plus.exe "/config"
  python3 /app/wg++/main.py -i "/data/guide.xml" -o "/data/guide_plex.xml" -m 80
  echo "Sleeping..."  
  sleep 28800
done
