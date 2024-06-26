# MAKEFILE =      Makefile
# ALL:    build
PREFIX = /usr

KERNELDIR ?= $(shell find /usr/src/linux-header* -maxdepth 0 -mindepth 0 -type d -print | head -n 1)
# KERNELDIR := /usr/src/linux-headers-4.15.18-vortex86dx3 

$(info PREFIX=$(PREFIX))
$(info DESTDIR=$(DESTDIR))
$(info KERNELDIR=$(KERNELDIR))
$(info DEB_BUILD_GNU_TYPE=$(DEB_BUILD_GNU_TYPE))
$(info DEB_HOST_GNU_TYPE=$(DEB_HOST_GNU_TYPE))
$(info DEB_HOST_MULTIARCH=$(DEB_HOST_MULTIARCH))

.PHONY: build
build:
	@echo "Building uio48..."
	$(MAKE) -C src KERNELDIR=$(KERNELDIR)

.PHONY: install
install:
	@echo "Installing uio48..."
	$(MAKE) -C src KERNELDIR=$(KERNELDIR) DESTDIR=$(DESTDIR) INSTALL_MOD_PATH=$(DESTDIR) modules_install
	$(MAKE) -C src DESTDIR=$(DESTDIR) PREFIX=$(PREFIX) install

.PHONY: clean
clean:
	@echo "Clean uio48..."
	$(MAKE) -C src clean
