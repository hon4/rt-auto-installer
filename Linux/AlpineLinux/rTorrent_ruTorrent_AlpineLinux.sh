#!/bin/ash
RED="\e[31m"
GREEN="\e[32m"
BLUE="\e[94m"
ENDCOLOR="\e[0m"

echo -e "${BLUE}[ INFO ]${ENDCOLOR} Adding Edge Community Repository"
echo "https://dl-cdn.alpinelinux.org/alpine/edge/community" >> /etc/apk/repositories
echo -e "${GREEN}[  OK  ]${ENDCOLOR} Edge Community Repository added!"

echo -e "${BLUE}[ INFO ]${ENDCOLOR} Starting a quick update..."
apk update
echo -e "${GREEN}[  OK  ]${ENDCOLOR} Quick update finished!"

echo -e "${BLUE}[ INFO ]${ENDCOLOR} Starting installation of rTorrent..."
apk add rtorrent || { echo -e "${RED}[FAILED]${ENDCOLOR} Failed to install rTorrent."; exit 1; }
echo -e "${GREEN}[  OK  ]${ENDCOLOR} rTorrent installation finished!"

echo -e "${BLUE}[ INFO ]${ENDCOLOR} Starting installation of xmlrpc-c..."
apk add xmlrpc-c || { echo -e "${RED}[FAILED]${ENDCOLOR} Failed to install xmlrpc-c."; exit 1; }
echo -e "${GREEN}[  OK  ]${ENDCOLOR} xmlrpc-c installation finished!"

echo -e "${BLUE}[ INFO ]${ENDCOLOR} Starting installation of Apache2..."
apk add apache2 || { echo -e "${RED}[FAILED]${ENDCOLOR} Failed to install Apache2."; exit 1; }
echo -e "${GREEN}[  OK  ]${ENDCOLOR} Apache2 installation finished!"

echo -e "${BLUE}[ INFO ]${ENDCOLOR} Starting installation of PHP..."
apk add php php-apache2 || { echo -e "${RED}[FAILED]${ENDCOLOR} Failed to install PHP."; exit 1; }
echo -e "${GREEN}[  OK  ]${ENDCOLOR} Apache2 installation finished!"

echo -e "${BLUE}[ INFO ]${ENDCOLOR} Restarting Apache2..."
rc-service apache2 restart || { echo -e "${RED}[FAILED]${ENDCOLOR} Failed to restart Apache2."; exit 1; }
echo -e "${GREEN}[  OK  ]${ENDCOLOR} Apache2 restart finished!"

echo -e "${BLUE}[ INFO ]${ENDCOLOR} Starting download of ruTorrent..."
wget https://github.com/Novik/ruTorrent/archive/refs/tags/v4.2.0.tar.gz -O ruTorrent_v4.2.0.tar.gz || { echo -e "${RED}[FAILED]${ENDCOLOR} Failed to download ruTorrent."; exit 1; }
echo -e "${GREEN}[  OK  ]${ENDCOLOR} ruTorrent download finished!"

echo -e "${BLUE}[ INFO ]${ENDCOLOR} Starting decompression of ruTorrent..."
rm -r ruTorrent-4.2.0
tar -xzvf ruTorrent_v4.2.0.tar.gz || { echo -e "${RED}[FAILED]${ENDCOLOR} Failed to decompress ruTorrent."; exit 1; }
echo -e "${GREEN}[  OK  ]${ENDCOLOR} ruTorrent decompression finished!"

echo -e "${BLUE}[ INFO ]${ENDCOLOR} Installing ruTorrent..."
if [ -d /var/www/localhost/htdocs_original ]; then
    rm -r /var/www/localhost/htdocs
else
    mv /var/www/localhost/htdocs /var/www/localhost/htdocs_original
fi
mv ruTorrent-4.2.0 /var/www/localhost/htdocs || { echo -e "${RED}[FAILED]${ENDCOLOR} Failed to install ruTorrent."; exit 1; }
echo -e "${GREEN}[  OK  ]${ENDCOLOR} ruTorrent installation finished!"

echo -e "${BLUE}[ INFO ]${ENDCOLOR} Setting permisions for folders share/torrents and share/settings of ruTorrent..."
chmod 777 /var/www/localhost/htdocs/share/torrents
chmod 777 /var/www/localhost/htdocs/share/settings
echo -e "${GREEN}[  OK  ]${ENDCOLOR} ruTorrent folders permisions set!"

echo -e "${BLUE}[ INFO ]${ENDCOLOR} Creating and setting permisions for downloads folder..."
mkdir -p /home/files/downloads
chmod 777 /home
chmod 777 /home/files
chmod -R 777 /home/files/downloads
echo -e "${GREEN}[  OK  ]${ENDCOLOR} Downloads folder created and permisions set!"

echo -e "${BLUE}[ INFO ]${ENDCOLOR} Setting Apache2 starting without commands..."
rc-update add apache2
echo -e "${GREEN}[  OK  ]${ENDCOLOR} Apache2 starting without commands setup finished!"

echo -e "${BLUE}[ INFO ]${ENDCOLOR} Downloading configuration files..."
wget https://raw.githubusercontent.com/hon4/rt-auto-installer/refs/heads/main/Linux/AlpineLinux/files/.rtorrent.rc -O ~/.rtorrent.rc
wget https://raw.githubusercontent.com/hon4/rt-auto-installer/refs/heads/main/Linux/AlpineLinux/files/rutorrent.conf -O /etc/apache2/conf.d/rutorrent.conf
echo -e "${GREEN}[  OK  ]${ENDCOLOR} Configuration files download finished..."



echo -e "${BLUE}[ INFO ]${ENDCOLOR} Starting installation of programs required by plugins..."
echo -e "${BLUE}[ INFO ]${ENDCOLOR} Starting installation of ffmpeg..."
apk add ffmpeg || { echo -e "${RED}[FAILED]${ENDCOLOR} Failed to install ffmpeg."; exit 1; }
echo -e "${GREEN}[  OK  ]${ENDCOLOR} ffmpeg installation finished!"

echo -e "${BLUE}[ INFO ]${ENDCOLOR} Starting installation of MediaInfo..."
apk add mediainfo || { echo -e "${RED}[FAILED]${ENDCOLOR} Failed to install MediaInfo."; exit 1; }
echo -e "${GREEN}[  OK  ]${ENDCOLOR} MediaInfo installation finished!"

echo -e "${BLUE}[ INFO ]${ENDCOLOR} Starting installation of SOX..."
apk add sox || { echo -e "${RED}[FAILED]${ENDCOLOR} Failed to install SOX."; exit 1; }
echo -e "${GREEN}[  OK  ]${ENDCOLOR} SOX installation finished!"
echo -e "${GREEN}[  OK  ]${ENDCOLOR} Rrograms required by plugins installation finished!"