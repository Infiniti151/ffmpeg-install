#!/usr/bin/fish

function update -d "update ffmpeg"
	sudo make uninstall
	rm rf ./build/\*
	./configure --enable-nonfree --enable-ffnvcodec --enable-libx264 --enable-libx265 --enable-cuda-llvm --extra-cflags=-I/usr/local/cuda/include --extra-ldflags=-L/usr/local/cuda/lib64 --disable-static --enable-shared --enable-gpl
	make -j 8
	sudo make install
	echo -e '\e[32mSuccessfully updated FFMpeg\e[0m' 
	sudo ldconfig
	ffmpeg
end

cd ~/ffmpeg
set -l latest (git pull > /dev/null && git branch -a | grep 'release' | tail -1 | string sub -s 18)
if test "$(git branch --show-current)" = $latest 
	if test -z (git fetch --dry-run)
	    echo -e '\e[31mNo update found\e[0m'
	else
	    git pull
	    update
	end
else
	git switch $latest
	update
end
