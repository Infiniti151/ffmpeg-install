#!/usr/bin/fish

cd ~/ffmpeg
if [ (git fetch --dry-run) = '' ]
    echo -e '\e[31mNo update found\e[0m'
else
    sudo make uninstall
    rm rf ./build/*
    git pull
    ./configure --enable-nonfree --enable-ffnvcodec --enable-cuda-llvm --extra-cflags=-I/usr/local/cuda/include --extra-ldflags=-L/usr/local/cuda/lib64 --disable-static --enable-shared
    make -j 8
    sudo make install
    echo -e '\e[32mSuccessfully updated FFMpeg\e[0m' 
    sudo ldconfig
    ffmpeg
