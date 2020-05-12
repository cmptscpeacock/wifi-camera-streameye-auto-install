#!/bin/bash

# variables

## credentials

## define console colours

RED='\033[0;31m' # red
WHITE='\033[1;37m' # white

## define formatting

UNDERLINE='\033[4m'
RESETUNDERLINE='\033[24m'

# user confirmation

printf "\n${RED}${UNDERLINE}IMPORTANT${WHITE}${RESETUNDERLINE}\n\nWifi Camera StreamEye is about to be uninstalled. Backup your streameye.sh file from /home/pi/streameye/extras/. \n\n"

while true; do
    read -p "Reboot needed prior to uninstallation. Have you rebooted? (Y - will continue | N - will reboot now)?" answer
    case $answer in
        [yY][eE][sS]|[yY]* )
            break;;
        [Nn][Oo]|[Nn]* ) 
            echo "Rebooting...";
            sleep 3 
            reboot;;
        * ) 
            echo "Please answer y|yes or n|no.";;
    esac
done

# remove previous versions

## stop streameye

sudo systemctl stop streameye

## delete streameye directory

if [ -d "/home/pi/streameye/" ]; then
  sudo rm -rf /home/pi/streameye/ > /dev/null 2>&1
fi

## check for streamsye service file

if
  [ -f "/lib/systemd/system/streameye.service" ]; then 
  sudo rm -rf /lib/systemd/system/streameye.service;
fi

## remove streamsye from systemd

sudo update-rc.d -f streameye remove

# install StreamEye
## Perform apt update and upgrade

printf "\nPerforming update and upgrade"
sudo apt-get update && sudo apt-get upgrade -y

## start camera module at boot

printf "\nEnabling Camera Module at boot"
sudo modprobe bcm2835-v4l2

## enable camera

printf "\nEnabling Camera"
sudo raspi-config nonint do_camera 0

## install packages

printf "\nInstalling Packages"
sudo apt-get install -y ffmpeg git gcc make python-picamera python3-picamera

## download and install streameye

printf "\nDownloading and Installing StreamEye"
git clone https://github.com/ccrisan/streameye.git
cd streameye
echo $'1\n1\n1' | make && 
sudo make install

## configure streameye service

wget -O streameye.sh https://raw.githubusercontent.com/cmptscpeacock/wifi-camera-streameye-auto-install/master/streameye.sh
sudo mv streameye.sh /home/pi/streameye/extras/streameye.sh
wget -O streameye.service https://raw.githubusercontent.com/cmptscpeacock/wifi-camera-streameye-auto-install/master/streameye.service
sudo mv streameye.service /lib/systemd/system/streameye.service
sudo systemctl --system daemon-reload
sudo systemctl enable streameye.service
sudo systemctl start streameye.service
sudo update-rc.d streameye defaults
printf "\n\n streameye is now running"