FROM debian:buster-slim

# Stop apt-get asking to get Dialog frontend
ENV DEBIAN_FRONTEND noninteractive
ENV TERM xterm

# Fix for JRE installation
RUN mkdir -p /usr/share/man/man1/

# Install dependencies
RUN dpkg --add-architecture i386 && \
    apt-get update && \
    apt-get install --no-install-recommends -y \
        bc \
        binutils \
        bsdmainutils \
        bzip2 \
        ca-certificates \
        curl \
        default-jre \
        file \
        gzip \
        iproute2 \
        jq \
        lib32gcc1 \
        lib32stdc++6 \
        libsdl2-2.0-0:i386 \
        locales \
        mailutils \
        netcat \
        nodejs \
        postfix \
        procps \
        python \
        tar \
        tmux \
        util-linux \
        unzip \
        wget && \
    apt-get -y autoremove && \
    apt-get -y clean && \
    rm -rf /var/lib/apt/lists/* && \
    rm -rf /tmp/* && \
    rm -rf /var/tmp/*
RUN curl -sL https://deb.nodesource.com/setup_14.x | bash - && \
    apt-get update && \
    apt-get install --no-install-recommends -y \
        nodejs && \
    apt-get -y autoremove && \
    apt-get -y clean && \
    rm -rf /var/lib/apt/lists/* && \
    rm -rf /tmp/* && \
    rm -rf /var/tmp/*

RUN npm set progress=false && \
    npm config set depth 0 && \
    npm install --no-audit --global gamedig && \
    npm cache clean --force

# # Set the locale
RUN sed -i -e 's/# en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /etc/locale.gen && \
    locale-gen
ENV LANG en_US.UTF-8  
ENV LANGUAGE en_US:en  
ENV LC_ALL en_US.UTF-8

# Add the steam user
RUN adduser \
    --disabled-login \
    --disabled-password \
    --gecos "" \
    --shell /bin/bash \
    linuxgsm && \
    usermod -G tty linuxgsm

# Switch to the user steam
USER linuxgsm

# Install LinuxGSM
WORKDIR /home/linuxgsm
RUN wget -q -O ./linuxgsm.sh https://linuxgsm.sh && \
    chmod +x ./linuxgsm.sh
