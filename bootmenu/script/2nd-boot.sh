#!/sbin/sh

######## BootMenu Script
######## Execute [2nd-boot] Menu


export PATH=/sbin:/system/xbin:/system/bin

######## Main Script

mount -o remount,rw /
rm -f /*.rc
cp -r -f /system/bootmenu/2nd-boot/* /
# chmod 755 /*.rc

## unmount devices
sync
umount /acct
umount /dev/cpuctl
umount /dev/pts
umount /mnt/asec
umount /mnt/obb
umount /cache
umount /data/tmp
umount /data
mount -o remount,rw,relatime,mode=775,size=128k /dev

######## Cleanup

rm /sbin/lsof

## busybox cleanup..
for cmd in $(/sbin/busybox --list); do
  [ -L "/sbin/$cmd" ] && rm "/sbin/$cmd"
done

rm /sbin/busybox


## adbd shell
ln -s /system/xbin/bash /sbin/sh

## reduce lcd backlight to save battery
echo 18 > /sys/class/leds/lcd-backlight/brightness


######## Let's go

/system/bootmenu/binary/2nd-boot

