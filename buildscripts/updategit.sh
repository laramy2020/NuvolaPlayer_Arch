#!/bin/bash
#
## create case statments for calling manual pushes or cron pushes
#
case "$1" in
	--cron)
		calltype=cron
		;;
	--manual)
		calltype=manual
		;;
esac
#
##end case statments
#

#
##Collect updated PKGBUILDS
#
aurdate=($(cat /home/user/.git/NuvolaPlayer_Arch_AUR/updated.txt))
rm /home/user/.git/NuvolaPlayer_Arch_AUR/updated.txt

curdate=$(date +"%Y-%m-%d")

#
##Was used for updateing github repo
#
#mvfiles=($(find NuvolaPlayer_Arch/ -name PKGBUILD | sed "s/NuvolaPlayer_Arch\//NuvolaPlayer_Arch_liveBuilds\//"))
#oldfiles=($(find NuvolaPlayer_Arch/ -name PKGBUILD))
#x=0
#for f in ${oldfiles[@]}
#do
#	cp $f ${mvfiles[$x]}
#	x=$((x+1))
#done
#
##End old code
#

#
##Push PKGBUILDS to github
#
cd /home/user/.git/NuvolaPlayer_Arch
git add *
git commit -m "$calltype PKGBUILD update on $curdate"
git push origin master
#
##End GITHUB PUSH
#

#
##push built packages to repo(s)
#
rsync -avc /home/user/.git/binaries/* userreposync@web.laramyblack.com:/var/www/clients/client1/web25/web/NuvolaPlayer/
#
## end push
#

#
##update aur with updated packages
#
cd /home/user/.git/NuvolaPlayer_Arch_AUR
for g in ${aurdate[@]}
do
	cd $(find . -name $g)
	git add PKGBUILD .SRCINFO
	git commit -m "$calltype update $curdate"
	git push
	cd /home/user/.git/NuvolaPlayer_Arch_AUR
done
#
##end update aur
#

#
## update sphinx with status
#
#
## end update sphinx
#
