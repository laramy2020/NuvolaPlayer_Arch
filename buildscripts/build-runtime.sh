#!/bin/bash
cd /home/user/.git/NuvolaPlayer_Arch_liveBuilds/runtime
dirs=(nuvolaruntime)
for f in ${dirs[@]}
do
	 cd $f
	 makepkg -f
	 #sudo pacman -U *.pkg.tar.* --noconfirm
         cp *.pkg.tar.* /home/user/.git/binaries
         cd ../
done
