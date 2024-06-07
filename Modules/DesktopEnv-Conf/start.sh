#!/usr/bin/env bash
#
# initializing wallpaper daemon
swww init &
# setting wallpaper
sww img /etc/nixos/Modules/Wallpapers/nixos-red.png &

nm-applet --indicator &

waybar &

dunst
