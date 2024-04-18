#!/usr/bin/fish

sudo nala install -y nvidia-cuda-toolkit build-essential yasm cmake libtool libc6 libc6-dev unzip wget libnuma1 libnuma-dev clang
git clone https://git.videolan.org/git/ffmpeg/nv-codec-headers.git
cd nv-codec-headers && sudo make install && ..
git clone https://git.ffmpeg.org/ffmpeg.git && cd ffmpeg
set -l ver (git branch -a | grep 'release' | tail -1 | string sub -s 18)
echo -e '\e[32mInstalling FFmpeg \e[33m'$ver'\e[0m'
git switch $ver
./configure --enable-nonfree --enable-ffnvcodec --enable-cuda-llvm --extra-cflags=-I/usr/local/cuda/include --extra-ldflags=-L/usr/local/cuda/lib64 --disable-static --enable-shared
make -j 8
sudo make install
..
rm -rf nv-codec-headers/ ffmpeg/ 
echo '/usr/local/ffmpeg/lib/' | sudo tee -a /etc/ld.so.conf
sudo ldconfig
ffmpeg
