#/bin/ash
echo "[ INFO ] Creating rt directory..."
rm -r rt
mkdir -p rt
cd rt

echo "[ INFO ] Installing required packages..." #ninja-build
apk add autoconf automake build-base cmake curl git libtool linux-headers perl pkgconf python3 python3-dev re2c tar
apk add boost-dev openssl-dev zlib-dev icu-dev

#libtorrent
echo "[ INFO ] Downloading libtorrent..."
wget https://github.com/rakshasa/rtorrent-archive/raw/master/libtorrent-0.13.8.tar.gz
tar -xvf libtorrent-0.13.8.tar.gz

cd libtorrent-0.13.8

./autogen.sh
./configure --prefix=/usr/local --with-openssl --enable-debug
make -j$(nproc)
make install

cd ..
#rtorrent
echo "[ INFO ] Downloading rtorrent..."
wget https://github.com/rakshasa/rtorrent-archive/raw/master/rtorrent-0.9.8.tar.gz
tar -xvf rtorrent-0.9.8.tar.gz

cd rtorrent-0.9.8

apk add curl-dev ncurses-dev xmlrpc-c-dev pkgconf build-base

./configure
make
make install