# Kernel version to use
VERSION=6.11.7
VERSION_MAJOR=$(firstword $(subst ., ,$(VERSION)))

# Dependencies (libncurses-dev is for menuconfig, if needed)
dependencies:
	sudo apt install build-essential flex bison libncurses-dev

# Download kernel source and extract it
download:
	wget https://cdn.kernel.org/pub/linux/kernel/v${VERSION_MAJOR}.x/linux-${VERSION}.tar.xz
	tar xf linux-${VERSION}.tar.xz

# Build the tiny config and collect the log
build: download
	cd linux-${VERSION}; \
	make tinyconfig; \
	make V=1 > ../build.log 2>&1

clean:
	rm -rf linux-${VERSION}.tar.xz linux-${VERSION} build.log