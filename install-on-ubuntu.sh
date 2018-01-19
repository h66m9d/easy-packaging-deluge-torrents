#!/bin/bash
#apt-get install deluge deluged deluge-console -y
deluge-console plugin -e Execute
killall deluged

cat > ~/.config/deluge/tartorrent.sh <<EOL
torrentid=\$1
torrentname=\$2
torrentnameunderline=\`echo \$torrentname | tr ' ' '_'\`
torrentpath=\$3

# recheck and remove
deluge-console recheck \$torrentid
deluge-console rm \$torrentid

# Go to torrent path
cd \$torrentpath
echo okay >> debug.txt
# make tarbal.gz package
tar -czvf .\$torrentnameunderline.tar.gz "\$torrentname"
rm -r "\$torrentname"
rm "\$torrentname"

# Rename to original name
mv .\$torrentnameunderline.tar.gz "\$torrentname.tar.gz"

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
