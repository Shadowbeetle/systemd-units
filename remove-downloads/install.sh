# Usage: ./install-remove-downloads.sh USERNAME
if [ -z $1 ]; then
  echo Usage: sudo /install-remove-downloads.sh USERNAME
  exit 1
fi

if [ "$1" = "-h" ]; then
  echo Usage: sudo ./install-remove-downloads.sh USERNAME
  exit 1
fi
SOURCE_DIR=$(pwd)
sed "s/{{USER}}/$1/" remove-downloads.sh.template > remove-downloads.sh
chmod +x remove-downloads.sh
sed "s/{{USER}}/$1/" remove-downloads.service.template > remove-downloads.service
cd /etc/systemd/system/
ln -sf $SOURCE_DIR/remove-downloads.timer remove-downloads.timer
ln -sf $SOURCE_DIR/remove-downloads.service remove-downloads.service 
cd $SOURCE_DIR
systemctl enable remove-downloads.timer
systemctl enable remove-downloads.service 
systemctl daemon-reload
