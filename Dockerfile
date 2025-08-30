# Build stage
FROM alpine:latest AS builder

# Install build dependencies
RUN apk add --no-cache \
    clang \
    llvm \
    make \
    libbpf-dev \
    linux-headers \
    elfutils-dev

# Set working directory
WORKDIR /build

# Copy source files
COPY xdp_pass.c Makefile ./

# Build the XDP program
RUN make

# Runtime stage
FROM alpine:latest

# Install runtime dependencies
RUN apk add --no-cache \
    bpftool \
    iproute2 \
    libbpf

# Create directory for XDP program
WORKDIR /xdp

# Copy the compiled XDP object file from builder
COPY --from=builder /build/xdp_pass.o ./

CMD ["/bin/sh"]
