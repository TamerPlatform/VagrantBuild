#!/bin/bash
# grep the PID of Marco which is sessions manager
PID=`pgrep marco`
# using marco idenitify DBUS_SESSION_BUS_ADDRESS
export DBUS_SESSION_BUS_ADDRESS=`grep -z DBUS_SESSION_BUS_ADDRESS /proc/$PID/environ|cut -d= -f2-`
# set proper wallpaper
gsettings set org.mate.background picture-filename "/usr/share/backgrounds/tamer-black1.png"