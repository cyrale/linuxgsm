#!/bin/bash

echo "Update Linux Game Server Managers to the last version after each start/restart"

cd /home/steam/linuxgsm && git pull
cd /

find /home/steam/linuxgsm -type f -name "*.sh" -exec chmod u+x {} \;
find /home/steam/linuxgsm -type f -name "*.py" -exec chmod u+x {} \;
chmod u+x /home/steam/linuxgsm/lgsm/functions/README.md
