#!/bin/sh

cd /app/wg++/bin/

# Every 8 hour means 60 * 60 * 8 = 28800 secs
# Or just run and kill the docker process once finished
while true
do
  echo "Executing..."
  mono WebGrab+Plus.exe "/config"
  python3 /app/wg++/main.py -i "/config/guide.xml" -o "/data/guide_plex.xml" -m 80 -M 200 -c "/config/category_mapping.json"
  echo "Sleeping..."  
  sleep 28800
done
