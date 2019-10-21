#!/bin/bash

rm /tmp/.X0-lock &>/dev/null || true

echo "Starting X in 2 seconds"
sleep 2
startx &
sleep 10

# Hide the cursor
unclutter -display :0 -idle 0.1 &

mkdir app/static/cache

python -u app/cache.py
python -u app/main.py &

sleep 10

# Launch chromium browser in fullscreen on that page
SCREEN_SCALE="${SCREEN_SCALE:-default 1.0}"
chromium --app=http://localhost:8080 --start-fullscreen --no-sandbox --user-data-dir --kiosk --force-device-scale-factor=$SCREEN_SCALE

# Use this for remote debug
#chromium --no-sandbox --disable-gpu --remote-debugging-address=0.0.0.0 --remote-debugging-port=9222 --headless http://localhost:8080

# For debugging
echo "Chromium browser exited unexpectedly."
free -h
echo "End of pi.sh ..."
