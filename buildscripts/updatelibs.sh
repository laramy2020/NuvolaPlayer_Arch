#!/bin/bash
cd /home/user/.git/NuvolaPlayer_Arch_liveBuilds/libs
dirs=(diorite nuvolasdk)
for f in ${dirs[@]}
do
	 cd $f
	 version=$(curl -s "https://github.com/tiliado/$f/releases" | grep "releases/tag/" | head -n 1 | sed "s/^.*tag\///" | sed "s/\".*//")
	 sed -i "s/\pkgver\=.*/pkgver\=$version/" PKGBUILD
	 shasum=$(makepkg -g)
	 sed -i "s/sha256sum.*/$shasum/" PKGBUILD
	 sed -i "s/md5sum.*/$shasum/" PKGBUILD
         cd ../
done
