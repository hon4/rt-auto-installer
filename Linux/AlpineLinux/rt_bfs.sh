echo "[ INFO ] Starting rTorrent Build From Source..."

echo "[ INFO ] Creating rtorrent_build folder..."
rm -r rtorrent_build
mkdir rtorrent_build
cd rtorrent_build

echo "[ INFO ] Installing required packages..."
apk add build-base zlib-dev openssl-dev linux-headers

echo "[ INFO ] Downloading libtorrent..."
wget https://github.com/rakshasa/rtorrent/releases/download/v0.9.8/libtorrent-0.13.8.tar.gz
echo "[ INFO ] Extracting libtorrent..."
tar -xzvf libtorrent-0.13.8.tar.gz
cd libtorrent-0.13.8

echo "[ INFO ] Configuring libtorrent..."
./configure --prefix=/usr/local
echo "[ INFO ] Building libtorrent..."
make -j$(nproc)
make install

echo "[  OK  ] libtorrent built and installed..."

cd ..

echo "[ INFO ] Installing required packages..."
apk add ncurses-dev curl-dev

echo "[ INFO ] Downloading rTorrent..."
wget https://github.com/rakshasa/rtorrent/releases/download/v0.9.8/rtorrent-0.9.8.tar.gz
echo "[ INFO ] Extracting rTorrent..."
tar -xzvf rtorrent-0.9.8.tar.gz
cd rtorrent-0.9.8

echo "[ INFO ] Configuring rTorrent..."
./configure --prefix=/usr/local
echo "[ INFO ] Building rTorrent..."
make -j$(nproc)
make install
echo "[  OK  ] rTorrent built and installed..."