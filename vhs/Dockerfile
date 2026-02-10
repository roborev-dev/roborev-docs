FROM golang:1.24-alpine AS builder

WORKDIR /src

# Copy go mod files first for caching
COPY go.mod go.sum ./
RUN go mod download

# Copy source and build
COPY . .
RUN go build -ldflags="-X github.com/roborev-dev/roborev/internal/version.Version=v999.0.0" \
    -o /roborev ./cmd/roborev

FROM alpine:3.19

# Install dependencies for roborev, VHS, and freeze screenshots
RUN apk add --no-cache ca-certificates git bash ttyd ffmpeg chromium fontconfig tmux font-liberation

# Install MesloLGS Nerd Font (works well with VHS)
RUN mkdir -p /usr/share/fonts/truetype && \
    wget -qO /usr/share/fonts/truetype/MesloLGS-NF-Regular.ttf "https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Regular.ttf" && \
    wget -qO /usr/share/fonts/truetype/MesloLGS-NF-Bold.ttf "https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Bold.ttf" && \
    wget -qO /usr/share/fonts/truetype/MesloLGS-NF-Italic.ttf "https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Italic.ttf" && \
    wget -qO /usr/share/fonts/truetype/MesloLGS-NF-BoldItalic.ttf "https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Bold%20Italic.ttf" && \
    fc-cache -f

# Install VHS (detect architecture)
RUN ARCH=$(uname -m) && \
    if [ "$ARCH" = "aarch64" ]; then VHS_ARCH="arm64"; else VHS_ARCH="x86_64"; fi && \
    wget -qO- "https://github.com/charmbracelet/vhs/releases/download/v0.8.0/vhs_0.8.0_Linux_${VHS_ARCH}.tar.gz" | tar xz -C /tmp && \
    mv /tmp/vhs_*/vhs /usr/local/bin/vhs && \
    rm -rf /tmp/vhs_*

# Install freeze for SVG screenshots (detect architecture)
RUN ARCH=$(uname -m) && \
    if [ "$ARCH" = "aarch64" ]; then FREEZE_ARCH="arm64"; else FREEZE_ARCH="x86_64"; fi && \
    wget -qO- "https://github.com/charmbracelet/freeze/releases/download/v0.2.2/freeze_0.2.2_Linux_${FREEZE_ARCH}.tar.gz" | tar xz -C /tmp && \
    mv /tmp/freeze_*/freeze /usr/local/bin/freeze && \
    rm -rf /tmp/freeze_* && \
    freeze --version

COPY --from=builder /roborev /usr/local/bin/roborev

# Create config pointing to local daemon
RUN mkdir -p /root/.roborev && \
    echo 'server_addr = "127.0.0.1:7373"' > /root/.roborev/config.toml

# Create chromium wrapper with no-sandbox for Docker
RUN mv /usr/bin/chromium-browser /usr/bin/chromium-browser-real && \
    printf '#!/bin/sh\nexec /usr/bin/chromium-browser-real --no-sandbox --disable-gpu "$@"\n' > /usr/bin/chromium-browser && \
    chmod +x /usr/bin/chromium-browser

# Mock xclip for clipboard operations (atotto/clipboard uses this on Linux)
RUN printf '#!/bin/sh\ncat > /dev/null\n' > /usr/local/bin/xclip && \
    chmod +x /usr/local/bin/xclip

WORKDIR /tapes
