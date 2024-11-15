# Kernel version to use
KERNEL_VERSION=6.11.7
KERNEL_VERSION_MAJOR=${firstword ${subst ., ,${KERNEL_VERSION}}}

# Default
all: clean download tinyconfig extract

# Dependencies (libncurses-dev is for menuconfig, if needed)
dependencies:
	sudo apt install build-essential flex bison libncurses-dev

# Download kernel source and extract it
download:
	wget https://cdn.kernel.org/pub/linux/kernel/v${KERNEL_VERSION_MAJOR}.x/linux-${KERNEL_VERSION}.tar.xz
	tar xf linux-${KERNEL_VERSION}.tar.xz

# Build the tiny config 
tinyconfig:
	cd linux-${KERNEL_VERSION}; \
	make tinyconfig;

allnoconfig:
	cd linux-${KERNEL_VERSION}; \
	make allnoconfig;

defconfig:
	cd linux-${KERNEL_VERSION}; \
	make defconfig;

menuconfig:
	cd linux-${KERNEL_VERSION}; \
	make menuconfig;

# Extract the compiled files
extract:
	cd linux-${KERNEL_VERSION}; \
	make V=1 -j4 > ../build.log 2>&1; \
	find . -name "*.o" > ../objects.log; \
	mkdir ../src; \
	../extract.sh ../objects.log ../src; \
	find ../src -type d > ../includes.log; \
	../includes.sh ../includes.log ../src

clean:
	rm -rf linux-${KERNEL_VERSION}.tar.xz linux-${KERNEL_VERSION} build.log objects.log includes.log src