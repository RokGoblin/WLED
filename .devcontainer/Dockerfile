FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive

# Install system dependencies
RUN apt-get update && apt-get install -y \
    python3 python3-pip python3-venv \
    git curl wget unzip xz-utils \
    build-essential ca-certificates \
    && rm -rf /var/lib/apt/lists/*

# Install Node.js (required for WLED UI asset build)
RUN curl -fsSL https://deb.nodesource.com/setup_20.x | bash - \
    && apt-get install -y nodejs

# Install PlatformIO
RUN pip3 install -U platformio

# Pre-install ESP8266 + ESP32 platforms
RUN pio platform install espressif8266 && \
    pio platform install espressif32

# Add user for VS Code
RUN useradd -ms /bin/bash vscode && usermod -aG dialout vscode

USER vscode
