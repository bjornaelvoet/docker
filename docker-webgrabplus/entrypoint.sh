#!/bin/sh

cd /app/wg++/bin/

# Every 8 hour means 60 * 60 * 8 = 28800 secs
# Or just run and kill the docker process once finished
while true
do
  echo "Executing..."
  mono WebGrab+Plus.exe "/config"
  echo "Sleeping..."  
  sleep 28800
done
