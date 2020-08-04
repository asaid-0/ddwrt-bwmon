#!/bin/sh

# Directory the installer is stored
SCRIPT_DIR=$(dirname ${0})
SCRIPT_DIR=$(cd ${SCRIPT_DIR} && pwd)

sh "$SCRIPT_DIR/stop.sh"

# Cleanup junk from previous versions
rm /jffs/www/bwreader.php
rm /jffs/www/bwreset.php
rm /tmp/www/bwreader.php
rm /tmp/www/bwreset.php
rm $SCRIPT_DIR/bwmon-autobackup.sh

chmod +x "$SCRIPT_DIR/startup.sh"
chmod +x "$SCRIPT_DIR/start.sh"
chmod +x "$SCRIPT_DIR/stop.sh"
chmod +x "$SCRIPT_DIR/backup.sh"
chmod +x "$SCRIPT_DIR/clean.sh"
chmod +x "$SCRIPT_DIR/bwmon-cron.sh"
chmod +x "$SCRIPT_DIR/bwmon.sh"
chmod +x "$SCRIPT_DIR/lighttpd-running.sh"
chmod +x "$SCRIPT_DIR/keep-alive.sh"
chmod +x "$SCRIPT_DIR/set-password.sh"
chmod +x "$SCRIPT_DIR/www/bwreader.cgi"
chmod +x "$SCRIPT_DIR/www/bwreset.cgi"

# copy the lighttpd configuration
stopservice lighttpd
if [ ! -d /jffs/etc ]
then
	mkdir /jffs/etc
fi
cp "$SCRIPT_DIR/etc/lighttpd.conf" "/jffs/etc/lighttpd.conf"
# cat /tmp/lighttpd.conf $SCRIPT_DIR/etc/lighttpd-append.txt > /jffs/etc/lighttpd.conf
startservice lighttpd

# confirmation
echo "Installation completed."
echo "Type $SCRIPT_DIR/startup.sh to start the script"
echo 
echo "For further robustness you may add $SCRIPT_DIR/keep-alive.sh to your router's cron jobs"
echo 
echo "You can visit the stats page by navigating to http://routerip/user/bwmon.html"
echo "If you are running lighttpd on your router use http://routerip:8000/bwmon.html"
