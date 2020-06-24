#bin/bash
names=`ls /Volumes |grep -v Mac`
base="/Volumes"
mkdir $base
tmpFile="/tmp/tmp.txt"
echo $tmpFile
sudo echo ""> $tmpFile
vo=""
for name in $names
do
    vo="/Volumes/$name"
	if [[ x`diskutil info $vo |grep 'File System Personality'|grep NTFS ` != "x" ]] ; then
       disk=`diskutil info $vo |grep Node|grep -o "/dev/disk.*"`
	   echo $name:$disk >> $tmpFile
	fi
done
echo $tmpFile
for l in `cat $tmpFile`
do
	diskutil umount /Volumes/${l%%:*}
done
for l in `cat $tmpFile`
do
	echo $l
    sudo	mkdir $base/${l%%:*}
    sudo mount_ntfs -o rw,nobrowse ${l##*:} $base/${l%%:*}
done
