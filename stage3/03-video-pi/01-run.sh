#!/bin/bash -e

# Video Pi artwork

install -v -D -m 644 files/opt/video_pi/video_pi_wallpaper.png ${ROOTFS_DIR}/opt/video_pi/video_pi_wallpaper.png

# Video Pi scripts

mkdir -p ${ROOTFS_DIR}/home/pi/bin
chown 1000:1000 ${ROOTFS_DIR}/home/pi/bin
install -v -m 755 -o 1000 -g 1000 files/home/pi/bin/video_pi_devmon ${ROOTFS_DIR}/home/pi/bin/video_pi_devmon
install -v -m 755 -o 1000 -g 1000 files/home/pi/bin/video_pi_play ${ROOTFS_DIR}/home/pi/bin/video_pi_play

# LXDE autostart

mkdir -p ${ROOTFS_DIR}/home/pi/.config/lxsession/LXDE
chown 1000:1000 ${ROOTFS_DIR}/home/pi/.config/lxsession
chown 1000:1000 ${ROOTFS_DIR}/home/pi/.config/lxsession/LXDE
install -v -m 644 -o 1000 -g 1000 files/home/pi/.config/lxsession/LXDE/autostart ${ROOTFS_DIR}/home/pi/.config/lxsession/LXDE/autostart

# MPV config

mkdir -p ${ROOTFS_DIR}/home/pi/.config/mpv
chown 1000:1000 ${ROOTFS_DIR}/home/pi/.config
chown 1000:1000 ${ROOTFS_DIR}/home/pi/.config/mpv
install -v -m 644 -o 1000 -g 1000 files/home/pi/.config/mpv/mpv.conf ${ROOTFS_DIR}/home/pi/.config/mpv/mpv.conf

# LXDE config

mkdir -p ${ROOTFS_DIR}/home/pi/.config/pcmanfm/LXDE
chown 1000:1000 ${ROOTFS_DIR}/home/pi/.config/pcmanfm
chown 1000:1000 ${ROOTFS_DIR}/home/pi/.config/pcmanfm/LXDE
install -v -m 644 -o 1000 -g 1000 files/home/pi/.config/pcmanfm/LXDE/desktop-items-0.conf ${ROOTFS_DIR}/home/pi/.config/pcmanfm/LXDE/desktop-items-0.conf
install -v -m 644 -o 1000 -g 1000 files/home/pi/.config/pcmanfm/LXDE/pcmanfm.conf ${ROOTFS_DIR}/home/pi/.config/pcmanfm/LXDE/pcmanfm.conf

# Desktop icons

mkdir -p ${ROOTFS_DIR}/home/pi/Desktop
chown 1000:1000 ${ROOTFS_DIR}/home/pi/Desktop
install -v -m 644 -o 1000 -g 1000 files/home/pi/Desktop/raspi-config.desktop ${ROOTFS_DIR}/home/pi/Desktop/raspi-config.desktop

# Autologin to GUI

ln -fs ${ROOTFS_DIR}/lib/systemd/system/graphical.target ${ROOTFS_DIR}/etc/systemd/default.target
ln -fs ${ROOTFS_DIR}/etc/systemd/system/autologin@.service ${ROOTFS_DIR}/etc/systemd/system/getty.target.wants/getty@tty1.service
sed ${ROOTFS_DIR}/etc/lightdm/lightdm.conf -i -e "s/^\(#\|\)autologin-user=.*/autologin-user=pi/"


# Custom packages

install -v -D -m 644 -o 1000 -g 1000 files/opt/video_pi/pkg/udevil/udevil_0.4.4+-1_armhf.deb ${ROOTFS_DIR}/opt/video_pi/pkg/udevil/udevil_0.4.4+-1_armhf.deb
install -v -D -m 644 -o 1000 -g 1000 files/opt/video_pi/pkg/mpv/mpv_0.27.0_armhf.deb ${ROOTFS_DIR}/opt/video_pi/pkg/mpv/mpv_0.27.0_armhf.deb
install -v -D -m 644 -o 1000 -g 1000 files/opt/video_pi/pkg/omxiv/omxiv_20180831-1_armhf.deb ${ROOTFS_DIR}/opt/video_pi/pkg/omxiv/omxiv_20180831-1_armhf.deb

on_chroot << EOF
apt install -y /opt/video_pi/pkg/udevil/udevil_0.4.4+-1_armhf.deb
apt install -y /opt/video_pi/pkg/mpv/mpv_0.27.0_armhf.deb
apt install -y /opt/video_pi/pkg/omxiv/omxiv_20180831-1_armhf.deb
rpi-update
EOF
