#!/bin/bash
ignore=false
case $1 in
        -i|--ignore-version)
                ignore=true
                ;;
cd /home/user/.git/NuvolaPlayer_Arch_liveBuilds/libs
touch updated.txt
dirs=(diorite nuvolasdk)
gitdirs=(libdri2-git)
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
for g in ${gitdirs[@]}
do
         cd $g
         realname=$(echo $g | sed s/\-git//)
	 #need to fix for other future authors
         version=$(curl -s "https://github.com/robclark/$realname/commits/master" | grep "libdri2/commit" | grep message | sed "s/^.*libdri2\/commit\///" | sed s/\".*// | head -n 1 | cut -c 1-6)
         curver=$(cat PKGBUILD | grep "pkgver=" | sed "s/^.*\=//")
         if [ "$version" != "$curver" ]
         then
                 sed -i "s/\pkgver\=.*/pkgver\=$version/" PKGBUILD
                 echo $g >> ../updated.txt
         fi
         cd ../
done

