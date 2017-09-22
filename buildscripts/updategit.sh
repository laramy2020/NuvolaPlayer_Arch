#!/bin/bash
curdate=$(date +"%Y-%m-%d")
cd /home/user/.git/
mvfiles=($(find NuvolaPlayer_Arch/ -name PKGBUILD | sed "s/NuvolaPlayer_Arch\//NuvolaPlayer_Arch_liveBuilds\//"))
oldfiles=($(find NuvolaPlayer_Arch/ -name PKGBUILD))
x=0
for f in ${oldfiles[@]}
do
	cp $f ${mvfiles[$x]}
	x=$((x+1))
done
cd /home/user/.git/NuvolaPlayer_Arch
git add *
git commit -m "Cron PKGBUILD update on $date"
git push origin master

#now also updates repo
rsync -avc /home/user/.git/binaries/* user@packages.site.com:/var/www/clients/client1/web25/web/NuvolaPlayer/
