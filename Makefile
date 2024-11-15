# Kernel version to use
VERSION=6.11.7
VERSION_MAJOR=${firstword ${subst ., ,${VERSION}}}

# Default
all: clean download tinyconfig extract

# Dependencies (libncurses-dev is for menuconfig, if needed)
dependencies:
	sudo apt install build-essential flex bison libncurses-dev

# Download kernel source and extract it
download:
	wget https://cdn.kernel.org/pub/linux/kernel/v${VERSION_MAJOR}.x/linux-${VERSION}.tar.xz
	tar xf linux-${VERSION}.tar.xz

# Build the tiny config 
tinyconfig:
	cd linux-${VERSION}; \
	make tinyconfig;

menuconfig:
	cd linux-${VERSION}; \
	make menuconfig;

allnoconfig:
	cd linux-${VERSION}; \
	make allnoconfig;

# Extract the compiled files
extract:
	cd linux-${VERSION}; \
	make V=1 -j4 > ../build.log 2>&1; \
	find . -name "*.o" > ../objects.log; \
	mkdir ../src; \
	../extract.sh ../objects.log ../src; \
	find ../src -type d > ../includes.log; \
	../includes.sh ../includes.log ../src

clean:
	rm -rf linux-${VERSION}.tar.xz linux-${VERSION} build.log objects.log includes.log src