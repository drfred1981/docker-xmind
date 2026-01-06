# KasmVNC base image with Ubuntu Jammy (22.04)
FROM ghcr.io/linuxserver/baseimage-kasmvnc:ubuntujammy

LABEL maintainer="Dmitrii Ageev <d.ageev@gmail.com>"

# XMind package info
ENV XMIND_FILE="Xmind-for-Linux-amd64bit-26.01.07153-202512110451.deb"
ENV XMIND_URL="https://dl3.xmind.app/${XMIND_FILE}"

# Install XMind and dependencies
RUN apt-get update && \
    apt-get install --no-install-recommends -y \
        curl \
        libgtk-3-0 \
        libnotify4 \
        libnss3 \
        libxss1 \
        libxtst6 \
        xdg-utils \
        libatspi2.0-0 \
        libsecret-1-0 && \
    curl -kL -o "/tmp/${XMIND_FILE}" "${XMIND_URL}" && \
    apt-get install -y "/tmp/${XMIND_FILE}" && \
    rm -f "/tmp/${XMIND_FILE}" && \
    apt-get purge -y --auto-remove curl && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Copy KasmVNC autostart configuration
COPY root/ /

# Expose web ports (HTTP and HTTPS)
EXPOSE 3000 3001
