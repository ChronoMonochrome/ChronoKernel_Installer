#!/sbin/sh

set -x

DEVICE=$(cat /default.prop | grep "ro.product.device=" | cut -d "=" -f2)
DEV_SCRIPT="init.samsungcodina.rc"
DEF_PROP="recovery_default.prop"

VERSION_LINE=$(cat /system/build.prop | grep "ro.build.version.release" | cut -d "=" -f2)
VX=$(echo $VERSION_LINE | cut -d "." -f1)
VY=$(echo $VERSION_LINE | cut -d "." -f2)

ramdisk_path="/tmp/"
dev_files="/tmp/"$DEVICE

if [ $VX == 5 ] ; then
	if [ $VY == 0 ] ; then
		echo "5.0" ;
		ramdisk_path=$ramdisk_path"5.0.x/5.0.x.cpio"
	fi
	
	mv -f /ramdisk/$DEV_SCRIPT /ramdisk/$DEV_SCRIPT".bak"
	mv -f /ramdisk/$DEF_PROP /ramdisk/$DEF_PROP".bak"
	cp $dev_files/$DEV_SCRIPT /ramdisk
	cp $dev_files/$DEF_PROP /ramdisk
	chmod 750 /ramdisk/$DEV_SCRIPT
	chmod 644 /ramdisk/$DEF_PROP
fi

if [ $VX == 4 ] ; then
	if [ $VY == 4 ] ; then
		echo "4.4" ;
		ramdisk_path=$ramdisk_path"4.4.x/4.4.x.cpio" 
	fi
	
	if [ $VY == 3 ] ; then
		echo "4.3" ;
		ramdisk_path=$ramdisk_path"4.3.x/4.3.x.cpio"
	fi
	
	if [ $VY == 2 ] ; then
		echo "4.2" ;
		ramdisk_path=$ramdisk_path"4.2.x/4.2.x.cpio"
	fi
	
	mv -f /ramdisk/$DEV_SCRIPT /ramdisk/$DEV_SCRIPT".bak"
	mv -f /ramdisk/$DEF_PROP /ramdisk/$DEF_PROP".bak"
	cp $dev_files/$DEV_SCRIPT /ramdisk
	cp $dev_files/$DEF_PROP /ramdisk
	chmod 750 /ramdisk/$DEV_SCRIPT
	chmod 644 /ramdisk/$DEF_PROP
	
	if [ $VY == 1 ] ; then
		echo "4.1" ;
		ramdisk_path=$ramdisk_path"4.1.x/4.1.x.cpio"
		cp -f /tmp/4.1.x/$DEV_SCRIPT /ramdisk
		chmod 750 /ramdisk/$DEV_SCRIPT
	fi
fi

mv -f /ramdisk/boot.cpio /ramdisk/boot.cpio.bak
cp $ramdisk_path /ramdisk/boot.cpio