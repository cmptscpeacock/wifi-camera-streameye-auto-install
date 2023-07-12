# Wifi Camera StreamEye

This script will uninstall and reinstall StreamEye. Backup your streameye.sh file from /home/pi/streameye/extras/.

The Wifi Camera is hosted by StreamEye and runs on a Raspberry Pi running Raspbian Buster Lite. It may function on other hardware and operating systems too, but at the time of writing this README they haven't been tested.

1. First the script asks if you have rebooted, and if not it will immediately reboot (be careful!). The reason for the reboot is to avoid any caching, which has been seen during testing. Once rebooted, re-run the script and continue.

2. The script will then go ahead and first uninstall any previous version of StreamEye then it will install the necessary files/folders for StreamEye..

3. Be warned that the process will replace the following files with files stored in github so backups of the files should be taken if you need the content within post-installation:
- /home/pi/streameye/extras/streameye.sh
- /lib/systemd/system/streameye.service

4. The script then configures StreamEye, using the variables for the camera settings as defined in streameye.sh.

5. No support is provided and no liability is accepted in the event of adverse outcome with the use of the script. If you choose to use it, it is your responsibility to test it before using.

6. The script can be invoked using:

#### Raspian
```bash
# enable camera
sudo raspi-config nonint do_camera 0
# ls /dev/video* # check camera module present

sudo reboot

cd /home/$USER
wget --no-cache -O streameye-install https://raw.githubusercontent.com/cmptscpeacock/wifi-camera-streameye-auto-install/master/wifi-camera-streameye-auto-install.bash && chmod +x streameye-install && ./streameye-install
```

## Copyright & Credit

### StreamEye

The StreamEye is managed by ccrisan, the creator and owner of the StreamEye. You can find the stable GitHub repo here: https://github.com/ccrisan/streameye
