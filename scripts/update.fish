#!/usr/bin/fish

function update -d "update ffmpeg"
	sudo make uninstall
	rm rf ./build/\*
	./configure --enable-nonfree --enable-ffnvcodec --enable-libx264 --enable-libx265 --enable-cuda-llvm --extra-cflags=-I/usr/local/cuda/include --extra-ldflags=-L/usr/local/cuda/lib64 --disable-static --enable-shared --enable-gpl
	make -j 8
	sudo make install
	echo (set_color green)Successfully updated FFMpeg(set_color normal) 
	sudo ldconfig
	ffmpeg
end

cd ~/ffmpeg
set -l latest (git pull > /dev/null && git branch -a | grep 'release' | tail -1 | string sub -s 18)
if test "$(git branch --show-current)" = $latest 
	if test -z (git fetch --dry-run)
	    echo (set_color red)No update found(set_color normal)
	else
	    git pull
	    update
	end
else
	git switch $latest
	update
end
