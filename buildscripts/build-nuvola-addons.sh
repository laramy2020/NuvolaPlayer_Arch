#!/bin/bash
cd /home/user/.git/NuvolaPlayer_Arch_liveBuilds/apps
dirs=($(cat updated.txt))
for f in ${dirs[@]}
do
	 cd $f
	 makepkg -f
	 gpg --detach-sign $f*.pkg.tar.*
	 repo-remove -s -k keyid /home/user/.git/binaries/NuvolaPlayer.db.tar.gz $f	
         cp *.pkg.tar.* /home/user/.git/binaries
	 cp PKGBUILD /home/user/.git/NuvolaPlayer_Arch/apps/$f/
         cp PKGBUILD /home/user/.git/NuvolaPlayer_Arch_AUR/apps/$f/
         makepkg --srcinfo > /home/user/.git/NuvolaPlayer_Arch_AUR/apps/$f/
	 repo-add -s -k keyid /home/user/.git/binaries/NuvolaPlayer.db.tar.gz /home/user/.git/binaries/$f*.pkg.tar.*
         cd ../
done
cat updated.txt >> /home/user/.git/NuvolaPlayer_Arch_AUR/updated.txt
rm updated.txt
