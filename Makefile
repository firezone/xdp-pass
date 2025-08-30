CLANG ?= clang
LLC ?= llc
ARCH := $(shell uname -m | sed 's/x86_64/x86/' | sed 's/aarch64/arm64/')

CFLAGS := -O2 -g -Wall -target bpf -D__TARGET_ARCH_$(ARCH)

all: xdp_pass.o

xdp_pass.o: xdp_pass.c
	$(CLANG) $(CFLAGS) -c $< -o $@

clean:
	rm -f xdp_pass.o

.PHONY: all clean