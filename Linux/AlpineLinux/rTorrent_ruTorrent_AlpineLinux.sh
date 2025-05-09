#!/bin/ash
RED="\e[31m"
GREEN="\e[32m"
BLUE="\e[94m"
ENDCOLOR="\e[0m"

echo -e "${BLUE}[ INFO ]${ENDCOLOR} Starting download of rTorrent and libtorrent..."
wget https://github.com/rakshasa/rtorrent-archive/raw/master/libtorrent-0.13.8.tar.gz || { echo -e "${RED}[FAILED]${ENDCOLOR} Failed to download libtorrent."; exit 1; }
wget https://github.com/rakshasa/rtorrent-archive/raw/master/rtorrent-0.9.8.tar.gz || { echo -e "${RED}[FAILED]${ENDCOLOR} Failed to download rTorrent."; exit 1; }
echo -e "${GREEN}[  OK  ]${ENDCOLOR} rTorrent installation finished!"

echo -e "${BLUE}[ INFO ]${ENDCOLOR} Starting installation of rTorrent and libtorrent compilation dependencies..."
apk add autoconf automake build-base zlib-dev openssl-dev libtool linux-headers || { echo -e "${RED}[FAILED]${ENDCOLOR} Failed to install build dependencies."; exit 1; }
echo -e "${GREEN}[  OK  ]${ENDCOLOR} Build dependencies installation finished!"

# libtorrent Start

echo -e "${BLUE}[ INFO ]${ENDCOLOR} Starting extraction of libtorrent..."
tar -xzvf libtorrent-0.13.8.tar.gz || { echo -e "${RED}[FAILED]${ENDCOLOR} Failed to extract libtorrent."; exit 1; }
echo -e "${GREEN}[  OK  ]${ENDCOLOR} libtorrent extraction finished!"

echo -e "${BLUE}[ INFO ]${ENDCOLOR} Entering libtorrent source directory..."
cd libtorrent-0.13.8 || { echo -e "${RED}[FAILED]${ENDCOLOR} Failed to enter libtorrent source directory."; exit 1; }
echo -e "${GREEN}[  OK  ]${ENDCOLOR} libtorrent source directory entered successfully!"

echo -e "${BLUE}[ INFO ]${ENDCOLOR} Starting libtorrent build from source..."
./autogen.sh || { echo -e "${RED}[FAILED]${ENDCOLOR} Failed build libtorrent from source (autogen.sh step)."; exit 1; }
./configure --prefix=/usr/local --disable-debug || { echo -e "${RED}[FAILED]${ENDCOLOR} Failed build libtorrent from source (configure step)."; exit 1; }
make -j$(nproc) || { echo -e "${RED}[FAILED]${ENDCOLOR} Failed build libtorrent from source (make step)."; exit 1; }
echo -e "${GREEN}[  OK  ]${ENDCOLOR} libtorrent build from source finished!"

echo -e "${BLUE}[ INFO ]${ENDCOLOR} Starting installation of compiled libtorrent..."
make install || { echo -e "${RED}[FAILED]${ENDCOLOR} Failed to install libtorrent."; exit 1; }
echo -e "${GREEN}[  OK  ]${ENDCOLOR} libtorrent installation finished!"

echo -e "${BLUE}[ INFO ]${ENDCOLOR} Starting cleanup of libtorrent build temporarly files..."
make clean || { echo -e "${RED}[FAILED]${ENDCOLOR} Failed clean temporarly libtorrent build files."; exit 1; }
echo -e "${GREEN}[  OK  ]${ENDCOLOR} libtorrent build temporarly files cleanup finished!"

echo -e "${BLUE}[ INFO ]${ENDCOLOR} Exiting libtorrent source directory..."
cd .. || { echo -e "${RED}[FAILED]${ENDCOLOR} Failed to exit libtorrent source directory."; exit 1; }
echo -e "${GREEN}[  OK  ]${ENDCOLOR} libtorrent source directory exited successfully!"

echo -e "${BLUE}[ INFO ]${ENDCOLOR} Starting deletion of libtorrent source directory..."
rm -rf libtorrent-0.13.8 || { echo -e "${RED}[FAILED]${ENDCOLOR} Failed to delete libtorrent source directory."; exit 1; }
echo -e "${GREEN}[  OK  ]${ENDCOLOR} libtorrent source directory deleted successfully!"

# libtorrent End

# rTorrent Start

echo -e "${BLUE}[ INFO ]${ENDCOLOR} Starting installing dependencies for rTorrent build..."
apk add ncurses-dev curl-dev xmlrpc-c-dev || { echo -e "${RED}[FAILED]${ENDCOLOR} Failed to install rTorrent build dependencies."; exit 1; }
echo -e "${GREEN}[  OK  ]${ENDCOLOR} rTorrent build dependencies installed successfully!"

echo -e "${BLUE}[ INFO ]${ENDCOLOR} Starting extraction of rTorrent..."
tar -xzvf rtorrent-0.9.8.tar.gz || { echo -e "${RED}[FAILED]${ENDCOLOR} Failed to extract rTorrent."; exit 1; }
echo -e "${GREEN}[  OK  ]${ENDCOLOR} rTorrent extraction finished!"

echo -e "${BLUE}[ INFO ]${ENDCOLOR} Entering rTorrent source directory..."
cd rtorrent-0.9.8 || { echo -e "${RED}[FAILED]${ENDCOLOR} Failed to enter rTorrent source directory."; exit 1; }
echo -e "${GREEN}[  OK  ]${ENDCOLOR} rTorrent source directory entered successfully!"

echo -e "${BLUE}[ INFO ]${ENDCOLOR} Starting rTorrent build from source..."
./configure --prefix=/usr/local --with-xmlrpc-c --disable-debug || { echo -e "${RED}[FAILED]${ENDCOLOR} Failed build rTorrent from source (configure step)."; exit 1; }
make -j$(nproc) || { echo -e "${RED}[FAILED]${ENDCOLOR} Failed build rTorrent from source (make step)."; exit 1; }
echo -e "${GREEN}[  OK  ]${ENDCOLOR} rTorrent built from source successfully!"

echo -e "${BLUE}[ INFO ]${ENDCOLOR} Starting installation of compiled rTorrent..."
make install || { echo -e "${RED}[FAILED]${ENDCOLOR} Failed to install rTorrent."; exit 1; }
echo -e "${GREEN}[  OK  ]${ENDCOLOR} rTorrent installation finished!"

echo -e "${BLUE}[ INFO ]${ENDCOLOR} Starting cleanup of rTorrent build temporarly files..."
make clean || { echo -e "${RED}[FAILED]${ENDCOLOR} Failed clean temporarly rTorrent build files."; exit 1; }
echo -e "${GREEN}[  OK  ]${ENDCOLOR} rTorrent build temporarly files cleanup finished!"

echo -e "${BLUE}[ INFO ]${ENDCOLOR} Exiting rTorrent source directory..."
cd .. || { echo -e "${RED}[FAILED]${ENDCOLOR} Failed to exit rTorrent source directory."; exit 1; }
echo -e "${GREEN}[  OK  ]${ENDCOLOR} rTorrent source directory exited successfully!"

echo -e "${BLUE}[ INFO ]${ENDCOLOR} Starting deletion of rTorrent source directory..."
rm -rf rtorrent-0.9.8 || { echo -e "${RED}[FAILED]${ENDCOLOR} Failed to delete rTorrent source directory."; exit 1; }
echo -e "${GREEN}[  OK  ]${ENDCOLOR} rTorrent source directory deleted successfully!"

# rTorrent End






echo -e "${BLUE}[ INFO ]${ENDCOLOR} Starting installation of Apache2..."
apk add apache2 apache2-proxy || { echo -e "${RED}[FAILED]${ENDCOLOR} Failed to install Apache2."; exit 1; }
echo -e "${GREEN}[  OK  ]${ENDCOLOR} Apache2 installation finished!"

echo -e "${BLUE}[ INFO ]${ENDCOLOR} Starting installation of PHP..."
apk add php php-apache2 || { echo -e "${RED}[FAILED]${ENDCOLOR} Failed to install PHP."; exit 1; }
echo -e "${GREEN}[  OK  ]${ENDCOLOR} PHP installation finished!"

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

echo -e "${BLUE}[ INFO ]${ENDCOLOR} Creating session directory and setting permisions..."
mkdir -p /home/session
chmod -R 777 /home/session
echo -e "${GREEN}[  OK  ]${ENDCOLOR} Session directory creation and permisions setup finished..."



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

echo -e "${BLUE}[ INFO ]${ENDCOLOR} Starting installation of curl..."
apk add curl || { echo -e "${RED}[FAILED]${ENDCOLOR} Failed to install curl."; exit 1; }
echo -e "${GREEN}[  OK  ]${ENDCOLOR} curl installation finished!"
echo -e "${GREEN}[  OK  ]${ENDCOLOR} Rrograms required by plugins installation finished!"
