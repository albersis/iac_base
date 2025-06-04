mkdir ~/media

mkdir ~/smb

sudo cp .creds ~/smb

sudo echo "//192.168.4.35/share /home/moob/media cifs uid=1000,gid=1000,credentials=~/smb/.creds,noexec 0 0" >> /etc/fstab

sudo mount -a
