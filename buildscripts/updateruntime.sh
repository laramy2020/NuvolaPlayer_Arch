#!/bin/bash
ignore=false
case $1 in
        -i|--ignore-version)
                ignore=true
                ;;
cd /home/user/.git/NuvolaPlayer_Arch_liveBuilds/runtime
touch updated.txt
dirs=(nuvolaruntime)
for f in ${dirs[@]}
do
	 cd $f
	 version=$(curl -s "https://github.com/tiliado/$f/releases" | grep "releases/tag/" | head -n 1 | sed "s/^.*tag\///" | sed "s/\".*//")
	 curver=$(cat PKGBUILD | grep "pkgver=" | sed "s/^.*\=//")
	 if [ "$version" != "$curver" ] || [ "$ignore" = "true" ]
	 then
		 sed -i "s/\pkgver\=.*/pkgver\=$version/" PKGBUILD
		 shasum=$(makepkg -g)
		 sed -i "s/sha256sum.*/$shasum/" PKGBUILD
		 sed -i "s/md5sum.*/$shasum/" PKGBUILD
		 echo $f >> ../updated.txt
	 fi
         cd ../
done
