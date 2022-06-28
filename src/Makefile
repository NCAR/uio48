# Makefile for uio48

ifneq ($(KERNELRELEASE),) # called by kbuild
	obj-m := uio48.o
else # called from command line

$(info ifneq KERNELRELEASE is empty)

# if KERNELDIR is empty, look on /usr/src
ifeq ($(KERNELDIR),)
KERNELDIR := $(shell find /usr/src -maxdepth 1 -mindepth 1 -type d -print | head -n 1)
endif

# if KERNELDIR is still empty, get current kernel version - assumes we're building
# for this host system.
ifeq ($(KERNELDIR),)
KERNELDIR := /lib/modules/$(shell uname -r)/build
endif

$(info KERNELDIR=$(KERNELDIR))

default:
	$(MAKE) -C $(KERNELDIR) M=$$PWD

endif

all: modules

install:
	install -d $(DESTDIR)$(PREFIX)/include
	install uio48.h $(DESTDIR)$(PREFIX)/include

modules modules_install::
	$(info modules_install INSTALL_MOD_PATH=$(INSTALL_MOD_PATH))
	$(RM) *.o.ur-safe
	@$(MAKE) -C $(KERNELDIR) M=$$PWD $@

clean:
	$(RM) -rf *.o *~ core .depend .*.cmd *.ko *.mod.c .tmp_versions /dev/uio48?
	@$(MAKE) -C $(KERNELDIR) M=$$PWD $@

uio48io.o: uio48io.c uio48.h Makefile
	gcc -c $(EXTRA_CFLAGS) uio48io.c

flash: flash.c uio48.h uio48io.o Makefile
	gcc -static flash.c uio48io.o -o flash
	chmod a+x flash

poll:  poll.c uio48.h uio48io.o Makefile
	gcc -D_REENTRANT -static poll.c uio48io.o -o poll -lpthread
	chmod a+x poll
 

# spotless:
# 	rm -rf ioctl poll flash Module.* *.o *~ core .depend .*.cmd *.ko *.mod.c *.order .tmp_versions /dev/uio48?
