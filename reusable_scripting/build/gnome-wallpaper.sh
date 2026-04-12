#!/usr/bin/bash

# Use for EL images that don't include this

echo "Installing GNOME Wallpaper"
curl https://gitlab.gnome.org/GNOME/gnome-backgrounds/-/archive/50.0/gnome-backgrounds-50.0.zip \
    > /tmp/gnome-backgrounds-50.0.zip
cd /tmp
unzip gnome-backgrounds-50.0.zip

mkdir /usr/share/backgrounds/gnome
cd gnome-backgrounds-50.0/backgrounds
cp *.jxl *.png *.svg /usr/share/backgrounds/gnome