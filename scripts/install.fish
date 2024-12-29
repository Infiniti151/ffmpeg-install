#!/usr/bin/fish

sudo apt install -y nvidia-cuda-toolkit build-essential yasm cmake libtool libc6 libc6-dev libx264-dev libx265-dev unzip wget libnuma1 libnuma-dev clang
git clone https://git.videolan.org/git/ffmpeg/nv-codec-headers.git ~/nv-codec-headers
cd ~/nv-codec-headers && sudo make install && ..
git clone https://git.ffmpeg.org/ffmpeg.git ~/ffmpeg && cd ~/ffmpeg
set -l latest (git branch -a | grep 'release' | tail -1 | string sub -s 18)
echo -e '\e[32mInstalling FFmpeg \e[33m'$latest'\e[0m'
git switch $latest
./configure --enable-nonfree --enable-ffnvcodec --enable-libx264 --enable-libx265 --enable-cuda-llvm --extra-cflags=-I/usr/local/cuda/include --extra-ldflags=-L/usr/local/cuda/lib64 --disable-static --enable-shared --enable-gpl
make -j 8
sudo make install
echo '/usr/local/ffmpeg/lib/' | sudo tee -a /etc/ld.so.conf
sudo ldconfig
ffmpeg
