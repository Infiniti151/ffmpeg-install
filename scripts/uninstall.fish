#!/usr/bin/fish

cd ~/
cd nv-codec-headers && sudo make uninstall && ..
cd ffmpeg && sudo make uninstall && ..
rm -rf nv-codec-headers ffmpeg
echo cat /etc/ld.so.conf | sed -i '_/usr/local/ffmpeg/lib/_d'
sudo ldconfig
echo -e ✔️ '\e[32mSuccessfully uninstalled FFMpeg!\e[0m'✔️
