# Kernel version to use
export VERSION=6.11.7

# Dependencies (libncurses-dev is for menuconfig, if needed)
sudo apt install build-essential flex bison libncurses-dev

# Download kernel source and extract it
wget https://cdn.kernel.org/pub/linux/kernel/v${VERSION:0:1}.x/linux-${VERSION}.tar.xz
tar xf linux-${VERSION}.tar.xz

# Build the tiny config
cd linux-${VERSION}
make tinyconfig

# Build kernel and collect the log
make V=1 > ../build.log 2>&1