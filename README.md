# Mini-OS

Extract a minimum kernel source tree from the Linux kernel source based on a kernel config

## Getting started

To make sure you have required dependencies (on Debian/Ubuntu-like systems), run:

```shell
make dependencies
```

To extract source tree, simply run `make`. Default options are kernel `6.11.8` and `tinyconfig`:

```shell
make
```

This will download the source tarball, extract it, config it, build it and extract source tree in `src` directory. Building the new source will come soon.

To use a specific version like x.y.z, use:

```shell
make KERNEL_VERSION=x.y.z
```

Manual targets are: `dependencies`, `download`, `allnoconfig`, `tinyconfig`, `defconfig`, `menuconfig`, `extract`, `clean`.