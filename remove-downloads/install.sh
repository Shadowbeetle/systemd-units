# Usage: ./install-remove-downloads.sh USERNAME
if [ "$1" = "-h" ]; then
  echo Usage: sudo ./install-remove-downloads.sh USERNAME PATH-TO-SCRIPT
  exit 1
fi

if [ -z $1 ] && [ -z $2 ]; then
  echo Usage: sudo /install-remove-downloads.sh USERNAME PATH-TO-SCRIPT
  exit 1
fi

SOURCE_DIR=$(pwd)
sed "s/{{USER}}/$1/" remove-downloads.sh.template > remove-downloads.sh
chmod +x remove-downloads.sh
sed "s|{{PATH}}|$2|" remove-downloads.service.template > remove-downloads.service
cd /etc/systemd/system/
ln -sf $SOURCE_DIR/remove-downloads.timer remove-downloads.timer
ln -sf $SOURCE_DIR/remove-downloads.service remove-downloads.service 
cd $SOURCE_DIR
systemctl daemon-reload
systemctl enable remove-downloads.timer
systemctl start remove-downloads.timer
systemctl enable remove-downloads.service 
systemctl start remove-downloads.service 
