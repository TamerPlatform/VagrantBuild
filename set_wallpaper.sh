#!/bin/bash
# grep the PID of Marco which is sessions manager
PID=`pgrep marco`
# using marco idenitify DBUS_SESSION_BUS_ADDRESS
export DBUS_SESSION_BUS_ADDRESS=`grep -z DBUS_SESSION_BUS_ADDRESS /proc/$PID/environ|cut -d= -f2-`
# set proper wallpaper
gsettings set org.mate.background picture-filename "/usr/share/backgrounds/tamer-black1.png"
sudo cp /vagrant/tamer-noninterlaced.png /boot/grub/tamer.png
sudo update-grub
sudo sed -i "s/background=.*/background=\/usr\/share\/backgrounds\/tamer-black1.png/g" /etc/lightdm/lightdm-gtk-greeter.conf
echo "" > ~/.zsh_history
