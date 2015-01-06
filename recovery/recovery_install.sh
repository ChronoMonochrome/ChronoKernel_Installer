#!sbin/sh

if ! test -f /ramdisk/recovery.cpio ; then
	cp /tmp/recovery.cpio /ramdisk/recovery.cpio
	chmod 644 /ramdisk/recovery.cpio
fi