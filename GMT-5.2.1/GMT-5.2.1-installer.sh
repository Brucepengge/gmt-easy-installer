#!/bin/bash
GMT_VERSION=5.2.1
GSHHG_VERSION=2.3.5
DCW_VERSION=1.1.2
GMT_INSTALL=/opt/GMT-${GMT_VERSION}

echo "Downloading files..."
wget -nv -c ftp://ftp.soest.hawaii.edu/gmt/gmt-${GMT_VERSION}-src.tar.gz
wget -nv -c ftp://ftp.soest.hawaii.edu/gmt/gshhg-gmt-${GSHHG_VERSION}.tar.gz
wget -nv -c ftp://ftp.soest.hawaii.edu/gmt/dcw-gmt-${DCW_VERSION}.tar.gz

# Verify the integrity of files
if ! md5sum --status -c md5sums.md5; then
    echo "#############################################################"
    echo "# Error in downloading files!                               #"
    echo "#############################################################"
    exit
fi

tar -xf gmt-${GMT_VERSION}-src.tar.gz
tar -xf gshhg-gmt-${GSHHG_VERSION}.tar.gz
tar -xf dcw-gmt-${DCW_VERSION}.tar.gz

mv gshhg-gmt-${GSHHG_VERSION} gmt-${GMT_VERSION}/share/gshhg
mv dcw-gmt-${DCW_VERSION} gmt-${GMT_VERSION}/share/dcw-gmt

cd gmt-${GMT_VERSION}

cat > cmake/ConfigUser.cmake << EOF
set (CMAKE_INSTALL_PREFIX "${GMT_INSTALL}")
set (GMT_INSTALL_MODULE_LINKS FALSE)
set (COPY_GSHHG TRUE)
set (COPY_DCW TRUE)
set (GMT_USE_THREADS TRUE)
EOF

mkdir build
cd build
cmake ..
make
sudo make install
cd ../..

echo "export GMT5HOME=${GMT_INSTALL}" >> ~/.bashrc
echo 'export PATH=${GMT5HOME}/bin:$PATH' >> ~/.bashrc
echo 'export LD_LIBRARY_PATH=${LD_LIBRARY_PATH}:${GMT5HOME}/lib64' >> ~/.bashrc
