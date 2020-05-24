FROM debian:stable-slim

RUN \
    dpkg --add-architecture i386 && \
    apt-get update && \
    apt-get install -y \
        ca-certificates \
        locales \
        locales-all \
        screen \
        curl \
        nano \
        p7zip-full && \
    apt-get clean && \
    echo "LC_ALL=en_US.UTF-8" >> /etc/environment && \
    rm -rf /var/lib/apt/lists/*

ENV LANG=en_US.UTF-8 \
    LANGUAGE=en_US.UTF-8 \
    LC_ALL=en_US.UTF-8

ENV VANILLA_VERSION=1404 \
    ARCHIVE_VERSION=038 \
    PORT=7777

# fix for favorites.json error
RUN favorites_path="/app/Worlds" && mkdir -p "$favorites_path" && echo "{}" > "$favorites_path/favorites.json"

COPY ./conf.sh /app/conf.sh
COPY ./server.sh /app/server.sh

# Set up Enviornment
RUN \
    curl -sL https://terraria.org/system/dedicated_servers/archives/000/000/$ARCHIVE_VERSION/original/terraria-server-$VANILLA_VERSION.zip --output /tmp/terraria-server.zip && \
    7z x /tmp/terraria-server.zip  -o/tmp && \
    mv /tmp/$VANILLA_VERSION/Linux/* /app && \
    rm -R /tmp/* && \
    useradd --home /app --gid root --system Terraria && \
    chown Terraria:root -R /app && \
    chmod +x /app/conf.sh && \
    chmod +x /app/server.sh && \
    chmod +x /app/TerrariaServer*

USER Terraria

WORKDIR /app

CMD ["/bin/bash"]

ONBUILD USER root

# Volumes for Persistent Server Data
VOLUME [ "/app/Worlds" ]
