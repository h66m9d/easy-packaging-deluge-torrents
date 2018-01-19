#!/bin/bash
#apt-get install deluge deluged deluge-console -y
killall deluged
deluge-console plugin -e Execute

cat > ~/.config/deluge/tartorrent.sh <<EOL
torrentid=\$1
torrentname=\$2
torrentnameunderline=\`echo \$2 | tr ' ' '_'\`
torrentpath=\$3

# recheck and remove
deluge-console recheck \$torrentid && deluge-console rm \$torrentid

if [ -d "\$torrentname" ]; then
# Go to torrent path
cd \$torrentpath

# make tarbal.gz package
tar -czvf .\$torrentnameunderline.tar.gz "\$torrentname"
rm -r "\$torrentname"

# Rename to original name
mv .\$torrentnameunderline.tar.gz "\$torrentname.tar.gz"
fi

EOL

chmod 755 ~/.config/deluge/tartorrent.sh

cat > ~/.config/deluge/execute.conf <<EOL
{
  "file": 1, 
  "format": 1
}{
  "commands": [
    [
      "1", 
      "complete", 
      "~/.config/deluge/tartorrent.sh"
    ]
  ]
}
EOL

deluged
