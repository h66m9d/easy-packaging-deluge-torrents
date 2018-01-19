apt-get install deluge deluged deluge-console -y
killall deluged
deluge-console plugin -e Execute

cat > ~/.config/deluge/tartorrent.sh <<EOL
#!/bin/bash
torrentid=\$1
torrentname=\$2
torrentnameunderline=\`echo \$2 | tr ' ' '_'\`
torrentpath=\$3

# recheck
deluge-console recheck \$torrentid

# Go to torrent path
cd \$3

# make tarbal.gz package
tar -czvf \$torrentnameunderline.tar.gz "\$torrentname"

# remove torrent with data
deluge-console rm --remove_data \$torrentid

# Rename to original name
# make tarbal.gz package
#mv $torrentnameunderline.tar.gz "\$torrentname.tar.gz"
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
