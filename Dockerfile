FROM alpine:3.6

RUN echo 'hosts: files dns' >> /etc/nsswitch.conf
RUN apk add --no-cache iputils lm_sensors tzdata ca-certificates net-snmp-tools ruby2.2 && \
    update-ca-certificates

ENV TELEGRAF_VERSION 1.4.4

COPY entrypoint.sh /entrypoint.sh

RUN set -ex && \
    apk add --no-cache --virtual .build-deps wget gnupg tar && \
    for key in \
        05CE15085FC09D18E99EFB22684A14CF2582E0C5 ; \
    do \
        gpg --keyserver ha.pool.sks-keyservers.net --recv-keys "$key" || \
        gpg --keyserver pgp.mit.edu --recv-keys "$key" || \
        gpg --keyserver keyserver.pgp.com --recv-keys "$key" ; \
    done && \
    wget -q https://dl.influxdata.com/telegraf/releases/telegraf-${TELEGRAF_VERSION}-static_linux_amd64.tar.gz.asc && \
    wget -q https://dl.influxdata.com/telegraf/releases/telegraf-${TELEGRAF_VERSION}-static_linux_amd64.tar.gz && \
    wget -O /usr/local/bin/netatmo https://raw.githubusercontent.com/benningm/docker-telegraf-netatmo/master/netatmo && \
    gpg --batch --verify telegraf-${TELEGRAF_VERSION}-static_linux_amd64.tar.gz.asc telegraf-${TELEGRAF_VERSION}-static_linux_amd64.tar.gz && \
    mkdir -p /usr/src /etc/telegraf /config && \
    tar -C /usr/src -xzf telegraf-${TELEGRAF_VERSION}-static_linux_amd64.tar.gz && \
    mv /usr/src/telegraf*/telegraf.conf /etc/telegraf/ && \
    chmod +x /usr/src/telegraf*/* /entrypoint.sh && \
    cp -a /usr/src/telegraf*/* /usr/bin/ && \
    rm -rf *.tar.gz* /usr/src /root/.gnupg && \
    apk del .build-deps

COPY telegraf_custom.conf /config/

VOLUME /config/

EXPOSE 8125/udp 8092/udp 8094

LABEL version=${TELEGRAF_VERSION}
LABEL url=https://api.github.com/repos/influxdata/telegraf/releases/latest

ENTRYPOINT ["/entrypoint.sh"]

CMD telegraf --config-directory /config/
