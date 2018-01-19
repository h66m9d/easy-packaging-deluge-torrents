#!/bin/bash
torrentid=$1
torrentname=$2
torrentnameunderline=`echo $2 | tr ' ' '_'`
torrentpath=$3

# recheck
deluge-console recheck $torrentid

# Go to torrent path
cd $3

# make tarbal.gz package
tar -czvf $torrentnameunderline.tar.gz "$torrentname"

# remove torrent with data
deluge-console rm --remove_data $torrentid

# Rename to original name
# make tarbal.gz package
#mv $torrentnameunderline.tar.gz "$torrentname.tar.gz"
