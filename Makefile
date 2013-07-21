
-include source.mk

all:
	$(CP) limit.patch $(SOURCE_DIR)/debian/patches/999_LIMIT.patch
	echo 999_LIMIT.patch >> $(SOURCE_DIR)/debian/patches/series
	(cd $(SOURCE_DIR); \
	debchange -llimit "Apply LIMIT patch"; \
	dpkg-buildpackage -rfakeroot -us -uc)

install:
	dpkg -i *.deb

clean:
	$(RM) -r $(SOURCE_DIR)
	$(RM) *.tar.gz *.dsc *.mk *.deb *.build *.changes

build-dep:
	apt-get build-dep flim

source: source.mk

source.mk:
	apt-get source flim
	echo SOURCE_DIR = `find flim-* -maxdepth 0` > $@

.PHONY: all install clean bulid-dep source
