#!/bin/bash
cd /home/lblack/.gitshit/NuvolaPlayer_Arch_liveBuilds/apps
dirs=($(cat updated.txt))
for f in ${dirs[@]}
do
	 cd $f
	 makepkg -f
	 repo-remove /home/lblack/.gitshit/binaries/NuvolaPlayer.db.tar.gz $f	
         cp *.pkg.tar.* /home/lblack/.gitshit/binaries
	 cp PKGBUILD /home/lblack/.gitshit/NuvolaPlayer_Arch/apps/$f/
	 repo-add /home/lblack/.gitshit/binaries/NuvolaPlayer.db.tar.gz /home/lblack/.gitshit/binaries/$f*.pkg.tar.*
         cd ../
done
rm updated.txt
