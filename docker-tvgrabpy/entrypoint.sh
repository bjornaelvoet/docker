#!/bin/sh

# Copy the config files
mkdir -p /home/appuser/.xmltv/
cp /conf/tv_grab_nl3_py.conf /home/appuser/.xmltv/
cp /conf/tv_grab_nl3_py.set /home/appuser/.xmltv/

# Start tvgrabpy every 8 hours
cd /app/tvgrabpyAPI

mkdir -p /home/appuser/.xmltv/

# Show informative the source list and detailed source list
python tv_grab_nl3.py --help

python tv_grab_nl3.py --show-sources

python tv_grab_nl3.py --show-detail-sources

# Every 4 hour means 60 * 60 * 4 = 14400 secs
# Or just run and kill the docker process once finished

while true
do
  echo "Executing..."
  #python tv_grab_nl3.py
  echo "Sleeping..."  
  sleep 14400
done

#python tv_grab_nl3.py --configure

#while true
#do
#  sleep 100
#done


