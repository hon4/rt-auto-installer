#!/bin/bash
echo "[ INFO ] Starting installation of rTorrent..."
apk add rtorrent
echo "[  OK  ] rTorrent installation finished!"

echo "[ INFO ] Starting installation of xmlrpc-c..."
apk add xmlrpc-c
echo "[  OK  ] xmlrpc-c installation finished!"

echo "[ INFO ] Starting installation of Apache2..."
apk add apache2
echo "[  OK  ] Apache2 installation finished!"

echo "[ INFO ] Starting installation of PHP..."
apk add php php-apache2
echo "[  OK  ] Apache2 installation finished!"

echo "[ INFO ] Restarting Apache2..."
rc-service apache2 restart
echo "[  OK  ] Apache2 restart finished!"

echo "[ INFO ] Starting download of ruTorrent..."
wget https://github.com/Novik/ruTorrent/archive/refs/tags/v4.2.0.tar.gz -O ruTorrent_v4.2.0.tar.gz
echo "[  OK  ] ruTorrent download finished!"

echo "[ INFO ] Starting decompression of ruTorrent..."
rm -r ruTorrent-4.2.0
tar -xzvf ruTorrent_v4.2.0.tar.gz
echo "[  OK  ] ruTorrent decompression finished!"

echo "[ INFO ] Installing ruTorrent..."
mv /var/www/localhost/htdocs /var/www/localhost/htdocs_original
mv ruTorrent-4.2.0 /var/www/localhost/htdocs
echo "[  OK  ] ruTorrent decompression finished!"
