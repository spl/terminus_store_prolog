# Architecture string used by `swipl`
SWIARCH = $(shell ./swiarch.pl)

# Pack shared object directory used by `swipl`
PACKSODIR = lib/$(SWIARCH)

RUST_LIB_NAME = terminus_store_prolog
RUST_TARGET=release
RUST_TARGET_DIR = rust/target/$(RUST_TARGET)/
RUST_TARGET_LOCATION = rust/target/$(RUST_TARGET)/lib$(RUST_LIB_NAME).$(SOEXT)
CARGO_FLAGS =

ifeq ($(SWIARCH), x64-win64)
SOEXT = dll
# NOTE: this is not guaranteed but we only support win64 now anyway
RUST_TARGET_LOCATION = rust/target/$(RUST_TARGET)/$(RUST_LIB_NAME).$(SOEXT)
else ifeq ($(SWIARCH), x86_64-darwin)
SOEXT = dylib
else
SOEXT = so
endif

TARGET = $(PACKSODIR)/libterminus_store.$(SOEXT)

all: release

build:
	mkdir -p $(PACKSODIR)
	cd rust; cargo build $(CARGO_FLAGS)
	cp $(RUST_TARGET_LOCATION) $(TARGET)

check::

debug: RUST_TARGET = debug
debug: build

release: CARGO_FLAGS += --release
release: build

windows_release: release

install::

clean:
	rm -rf *.$(SOEXT) lib buildenv.sh
	cd rust; cargo clean
