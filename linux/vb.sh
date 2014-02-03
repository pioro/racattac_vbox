#!/bin/bash

. conf.sh

# check if VB dir exist 

if [ ! -f ${VBDIR}/VBoxManage ] ; then
	echo "No VirtualBox installation found. Exiting"
	exit 1;
fi

export PATH=${VBDIR}:$PATH

# check if host interface exist if yes check IP

if ( ifconfig | grep ${HOSTONLYNETNAME} > /dev/null ) ; then
	# check IP
	echo Hostonly network exist - checking IP
	if ( ifconfig ${HOSTONLYNETNAME} | grep ${HOSTIP} ); then
		echo IP address OK
	else
		echo Hostonly network - ${HOSTONLYNETNAME} has a wrong IP address. Exiting
		exit 1
	fi
else
	# Creating network 
	echo Hostonly network doesn''t exist - creating
	VBoxManage hostonlyif create ipconfig  ${HOSTONLYNETNAME} --ip $HOSTIP --netmask 255.255.255.0
	VBoxManage dhcpserver modify --ifname  ${HOSTONLYNETNAME} --ip $DHCPIP --netmask 255.255.255.0 --lowerip $LOWIP --upperip $HIGHIP --enable
fi


mkdir -p $VMFOLDER
echo Generating script
rm -f vboxrun.sh


while read LINE ; do
	O1=${LINE/VMFOLDERHOLDER/$VMFOLDER}
	O2=${O1/COLLABN1VDIHOLDER/$COLLABN1VDI}
	O3=${O2/ORACLEISOPATHHOLDER/$ORACLEISOPATH}
	O4=${O3/DOWNLOADFOLDERHOLDER/$DOWNLOADFOLDER}
	O5=${O4/HOSTONLYNETNAMEHOLDER/$HOSTONLYNETNAME}
	echo $O5 >> vboxrun.sh
done < vb.vboxs

#for /F "delims=;" %%A in (vb.vboxs) do call replace_line.bat "%%A"

#echo Script generated. Press Enter to create a VirtualBox configuration
#pause 0
#call vboxrun.bat


