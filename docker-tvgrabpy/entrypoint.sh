#!/bin/sh

# Copy the config files
mkdir -p /home/appuser/.xmltv/
cp /conf/tv_grab_nl3_py.conf /home/appuser/.xmltv/
cp /conf/tv_grab_nl3_py.set /home/appuser/.xmltv/

cd /app/tvgrabpyAPI

# Show informative the source list and detailed source list
python tv_grab_nl3.py --show-sources

python tv_grab_nl3.py --show-detail-sources

# Every 4 hour means 60 * 60 * 4 = 14400 secs
# Or just run and kill the docker process once finished
while true
do
  echo "Executing..."
  python tv_grab_nl3.py --output /data/guide.xml --disable-source 1 --disable-source 2 --disable-source 3 --disable-source 4 --disable-source 5 --disable-source 7 --disable-source 8 --disable-source 9 --disable-source 10 --disable-source 11 --disable-source 12 --disable-detail-source 1 --disable-detail-source 3 --disable-detail-source 4 
  echo "Sleeping for 4 hours"  
  sleep 14400
done
