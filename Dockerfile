FROM docker/compose:1.23.2

# Installs cypress dependencies
RUN apk add --update nodejs-current nodejs-npm curl gtk+2.0 libnotify gconf nss xvfb python build-base bash

RUN npm install -g npm@6.4.1 strip-ansi yarn

# versions of local tools
RUN node -v
RUN npm -v
RUN yarn -v

# Installs latest Chromium package.
RUN apk update && apk upgrade \
    && echo @edge http://nl.alpinelinux.org/alpine/edge/community >> /etc/apk/repositories \
    && echo @edge http://nl.alpinelinux.org/alpine/edge/main >> /etc/apk/repositories \
    && apk add --no-cache \
    freetype@edge \
    harfbuzz@edge \
    chromium@edge \
    nss@edge \
    && rm -rf /var/lib/apt/lists/* \
    /var/cache/apk/* \
    /usr/share/man \
    /tmp/*

# Add Chrome as a user
RUN mkdir -p /usr/src/app \
    && adduser -D chrome \
    && chown -R chrome:chrome /usr/src/app
# Run Chrome as non-privileged
USER chrome
WORKDIR /usr/src/app

ENV CHROME_BIN=/usr/bin/chromium-browser \
    CHROME_PATH=/usr/lib/chromium/
