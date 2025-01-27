#!/bin/bash
RED="\e[31m"
GREEN="\e[32m"
BLUE="\e[94m"
ENDCOLOR="\e[0m"

echo -e "${BLUE}[ INFO ]${ENDCOLOR} Starting a quick update..."
apt-get update
echo -e "${GREEN}[  OK  ]${ENDCOLOR} Quick update finished!"

echo -e "${BLUE}[ INFO ]${ENDCOLOR} Starting installation of rTorrent..."
apt-get install rtorrent -y || { echo -e "${RED}[FAILED]${ENDCOLOR} Failed to install rTorrent."; exit 1; }
echo -e "${GREEN}[  OK  ]${ENDCOLOR} rTorrent installation finished!"

echo -e "${BLUE}[ INFO ]${ENDCOLOR} Starting installation of Apache2..."
apt-get install apache2 -y || { echo -e "${RED}[FAILED]${ENDCOLOR} Failed to install Apache2."; exit 1; }
echo -e "${GREEN}[  OK  ]${ENDCOLOR} Apache2 installation finished!"

echo -e "${BLUE}[ INFO ]${ENDCOLOR} Starting installation of PHP..."
apt-get install php libapache2-mod-php -y || { echo -e "${RED}[FAILED]${ENDCOLOR} Failed to install PHP."; exit 1; }
echo -e "${GREEN}[  OK  ]${ENDCOLOR} PHP installation finished!"

echo -e "${BLUE}[ INFO ]${ENDCOLOR} Restarting Apache2..."
systemctl restart apache2 || { echo -e "${RED}[FAILED]${ENDCOLOR} Failed to restart Apache2."; exit 1; }
echo -e "${GREEN}[  OK  ]${ENDCOLOR} Apache2 restart finished!"

echo -e "${BLUE}[ INFO ]${ENDCOLOR} Starting download of ruTorrent..."
wget https://github.com/Novik/ruTorrent/archive/refs/tags/v4.2.0.tar.gz -O ruTorrent_v4.2.0.tar.gz || { echo -e "${RED}[FAILED]${ENDCOLOR} Failed to download ruTorrent."; exit 1; }
echo -e "${GREEN}[  OK  ]${ENDCOLOR} ruTorrent download finished!"

echo -e "${BLUE}[ INFO ]${ENDCOLOR} Starting decompression of ruTorrent..."
rm -r ruTorrent-4.2.0
tar -xzvf ruTorrent_v4.2.0.tar.gz || { echo -e "${RED}[FAILED]${ENDCOLOR} Failed to decompress ruTorrent."; exit 1; }
echo -e "${GREEN}[  OK  ]${ENDCOLOR} ruTorrent decompression finished!"

echo -e "${BLUE}[ INFO ]${ENDCOLOR} Installing ruTorrent..."
if [ -d /var/www/html_original ]; then
    rm -r /var/www/html
else
    mv /var/www/html /var/www/html_original
fi
mv ruTorrent-4.2.0 /var/www/html || { echo -e "${RED}[FAILED]${ENDCOLOR} Failed to install ruTorrent."; exit 1; }
echo -e "${GREEN}[  OK  ]${ENDCOLOR} ruTorrent installation finished!"

echo -e "${BLUE}[ INFO ]${ENDCOLOR} Setting permisions for folders share/torrents and share/settings of ruTorrent..."
chmod 777 /var/www/html/share/torrents
chmod 777 /var/www/html/share/settings
echo -e "${GREEN}[  OK  ]${ENDCOLOR} ruTorrent folders permisions set!"

echo -e "${BLUE}[ INFO ]${ENDCOLOR} Creating and setting permisions for downloads folder..."
mkdir -p /home/files/downloads
chmod 777 /home
chmod 777 /home/files
chmod -R 777 /home/files/downloads
echo -e "${GREEN}[  OK  ]${ENDCOLOR} Downloads folder created and permisions set!"

echo -e "${BLUE}[ INFO ]${ENDCOLOR} Setting Apache2 starting without commands..."
systemctl restart apache2
echo -e "${GREEN}[  OK  ]${ENDCOLOR} Apache2 starting without commands setup finished!"

echo -e "${BLUE}[ INFO ]${ENDCOLOR} Downloading configuration files..."
wget https://raw.githubusercontent.com/hon4/rt-auto-installer/refs/heads/main/Linux/AlpineLinux/files/.rtorrent.rc -O /root/.rtorrent.rc
wget https://raw.githubusercontent.com/hon4/rt-auto-installer/refs/heads/main/Linux/AlpineLinux/files/rutorrent.conf -O /etc/apache2/conf.d/rutorrent.conf
echo -e "${GREEN}[  OK  ]${ENDCOLOR} Configuration files download finished..."

echo -e "${BLUE}[ INFO ]${ENDCOLOR} Creating session directory and setting permisions..."
mkdir -p /home/session
chmod -R 777 /home/session
echo -e "${GREEN}[  OK  ]${ENDCOLOR} Session directory creation and permisions setup finished..."

echo -e "${BLUE}[ INFO ]${ENDCOLOR} Setting rTorrent starting without commands..."
echo -e "${BLUE}[ INFO ]${ENDCOLOR} Starting installation of tmux..."
apt-get install tmux -y || { echo -e "${RED}[FAILED]${ENDCOLOR} Failed to install tmux."; exit 1; }
echo -e "${GREEN}[  OK  ]${ENDCOLOR} tmux installation finished!"

echo -e "${BLUE}[ INFO ]${ENDCOLOR} Downloading service configuration files..."
wget https://raw.githubusercontent.com/hon4/rt-auto-installer/refs/heads/main/Linux/Bodhi/i686/files/rtorrent.service -O /etc/systemd/system/rtorrent.service
echo -e "${GREEN}[  OK  ]${ENDCOLOR} Service configuration files download finished..."

echo -e "${BLUE}[ INFO ]${ENDCOLOR} Reloading systemctl..."
systemctl daemon-reload
echo -e "${GREEN}[  OK  ]${ENDCOLOR} systemctl reload finished!"

echo -e "${BLUE}[ INFO ]${ENDCOLOR} Enabling rTorrent..."
systemctl enable rtorrent
echo -e "${BLUE}[ INFO ]${ENDCOLOR} rTorrent enable finished!"

echo -e "${BLUE}[ INFO ]${ENDCOLOR} Starting rTorrent..."
systemctl start rtorrent
echo -e "${BLUE}[ INFO ]${ENDCOLOR} rTorrent start finished!"
echo -e "${GREEN}[  OK  ]${ENDCOLOR} rTorrent starting without commands setup finished!"



echo -e "${BLUE}[ INFO ]${ENDCOLOR} Starting installation of programs required by plugins..."
echo -e "${BLUE}[ INFO ]${ENDCOLOR} Starting installation of ffmpeg..."
apt-get install ffmpeg -y || { echo -e "${RED}[FAILED]${ENDCOLOR} Failed to install ffmpeg."; exit 1; }
echo -e "${GREEN}[  OK  ]${ENDCOLOR} ffmpeg installation finished!"

echo -e "${BLUE}[ INFO ]${ENDCOLOR} Starting installation of MediaInfo..."
apt-get install mediainfo -y || { echo -e "${RED}[FAILED]${ENDCOLOR} Failed to install MediaInfo."; exit 1; }
echo -e "${GREEN}[  OK  ]${ENDCOLOR} MediaInfo installation finished!"

echo -e "${BLUE}[ INFO ]${ENDCOLOR} Starting installation of SOX..."
apt-get install sox -y || { echo -e "${RED}[FAILED]${ENDCOLOR} Failed to install SOX."; exit 1; }
echo -e "${GREEN}[  OK  ]${ENDCOLOR} SOX installation finished!"

echo -e "${BLUE}[ INFO ]${ENDCOLOR} Starting installation of curl..."
apt-get install curl -y || { echo -e "${RED}[FAILED]${ENDCOLOR} Failed to install curl."; exit 1; }
echo -e "${GREEN}[  OK  ]${ENDCOLOR} curl installation finished!"

echo -e "${BLUE}[ INFO ]${ENDCOLOR} Starting installation of unzip..."
apt-get install unzip -y || { echo -e "${RED}[FAILED]${ENDCOLOR} Failed to install unzip."; exit 1; }
echo -e "${GREEN}[  OK  ]${ENDCOLOR} unzip installation finished!"

echo -e "${BLUE}[ INFO ]${ENDCOLOR} Starting installation of unrar..."
apt-get install unrar -y || { echo -e "${RED}[FAILED]${ENDCOLOR} Failed to install unrar."; exit 1; }
echo -e "${GREEN}[  OK  ]${ENDCOLOR} unrar installation finished!"
echo -e "${GREEN}[  OK  ]${ENDCOLOR} Rrograms required by plugins installation finished!"
