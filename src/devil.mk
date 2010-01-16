# This file is part of mingw-cross-env.
# See doc/index.html or doc/README for further information.

# DevIL
PKG             := devil
$(PKG)_IGNORE   :=
$(PKG)_VERSION  := 1.7.8
$(PKG)_CHECKSUM := bc27e3e830ba666a3af03548789700d10561fcb1
$(PKG)_SUBDIR   := devil-$($(PKG)_VERSION)
$(PKG)_FILE     := DevIL-$($(PKG)_VERSION).tar.gz
$(PKG)_WEBSITE  := http://openil.sourceforge.net/
$(PKG)_URL      := http://$(SOURCEFORGE_MIRROR)/project/openil/DevIL/$($(PKG)_VERSION)/$($(PKG)_FILE)
$(PKG)_DEPS     := gcc zlib openexr jpeg jasper lcms libmng libpng tiff sdl

define $(PKG)_UPDATE
    wget -q -O- 'http://openil.svn.sourceforge.net/viewvc/openil/tags/?sortby=date' | \
    grep '<a name="' | \
    $(SED) -n 's,.*<a name="release-\([0-9][^"]*\)".*,\1,p' | \
    head -1
endef

define $(PKG)_BUILD
    $(SED) 's,__declspec(dllimport),,' -i '$(1)/include/IL/il.h'
    # wine confuses the cross-compiling detection, so set it explicitly
    $(SED) 's,cross_compiling=no,cross_compiling=yes,' -i '$(1)/configure'
    cd '$(1)' && ./configure \
        --host='$(TARGET)' \
        --disable-shared \
        --prefix='$(PREFIX)/$(TARGET)' \
        --enable-ILU \
        --enable-ILUT \
        --disable-allegro \
        --enable-directx8 \
        --enable-directx9 \
        --enable-opengl \
        --enable-sdl \
        --disable-sdltest \
        --disable-wdp \
        --with-zlib \
        --without-squish \
        --without-nvtt \
        --without-x \
        --without-examples
    $(MAKE) -C '$(1)' -j '$(JOBS)' install bin_PROGRAMS= sbin_PROGRAMS= noinst_PROGRAMS= INFO_DEPS=
endef