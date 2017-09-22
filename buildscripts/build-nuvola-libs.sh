
#!/bin/bash
cd /home/user/.git/NuvolaPlayer_Arch_liveBuilds/libs
dirs=($(cat updated.txt))
for f in ${dirs[@]}
do
	 cd $f
	 makepkg -f
	 repo-remove /home/user/.git/binaries/NuvolaPlayer.db.tar.gz $f
	 #sudo pacman -U *.pkg.tar.* --noconfirm
         cp *.pkg.tar.* /home/user/.git/binaries
 	 cp PKGBUILD /home/user/.git/NuvolaPlayer_Arch/libs/$f/
	 repo-add /home/user/.git/binaries/NuvolaPlayer.db.tar.gz /home/user/.git/binaries/$f*.pkg.tar.*
         cd ../
done
rm updated.txt
