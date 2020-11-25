FROM ubuntu:20.04

ARG gosu_ver=1.10

COPY bin/clickhouse /usr/bin/clickhouse
COPY bin/clickhouse-odbc-bridge /usr/bin/clickhouse-odbc-bridge

RUN apt update && apt -y install libcap2-bin locales locales-all && \
    locale-gen en_US.UTF-8 && \
    ln -s /usr/bin/clickhouse /usr/bin/clickhouse-benchmark && \
    ln -s /usr/bin/clickhouse /usr/bin/clickhouse-client && \
    ln -s /usr/bin/clickhouse /usr/bin/clickhouse-compressor && \
    ln -s /usr/bin/clickhouse /usr/bin/clickhouse-copier && \
    ln -s /usr/bin/clickhouse /usr/bin/clickhouse-extract-from-config && \
    ln -s /usr/bin/clickhouse /usr/bin/clickhouse-format && \
    ln -s /usr/bin/clickhouse /usr/bin/clickhouse-local && \
    ln -s /usr/bin/clickhouse /usr/bin/clickhouse-obfuscator && \
    ln -s /usr/bin/clickhouse /usr/bin/clickhouse-server

RUN useradd clickhouse -s /bin/bash

RUN mkdir -p /etc/clickhouse-client/config.d /etc/clickhouse-server/config.d /etc/clickhouse-server/users.d && \
    mkdir -p /var/lib/clickhouse /var/log/clickhouse-server /home/clickhouse /docker-entrypoint-initdb.d

COPY config/config.xml /etc/clickhouse-server/
COPY config/users.xml /etc/clickhouse-server/
COPY config/docker_related_config.xml /etc/clickhouse-server/config.d/
COPY config/clickhouse.limits /etc/security/limits.d/clickhouse.conf
COPY config/clickhouse-client.xml /etc/clickhouse-client/config.xml
COPY entrypoint.sh /entrypoint.sh

ENV LANG=en_US.UTF-8 \
    LANGUAGE=en_US:en \
    LC_ALL=en_US.UTF-8 \
    TZ=Europe/Oslo \
    CLICKHOUSE_CONFIG=/etc/clickhouse-server/config.xml

ADD https://github.com/tianon/gosu/releases/download/$gosu_ver/gosu-amd64 /bin/gosu

RUN chmod +x /entrypoint.sh /bin/gosu && \
    chown -R clickhouse:clickhouse /etc/clickhouse-client \
    /etc/clickhouse-server /var/lib/clickhouse /var/log/clickhouse-server \
    /home/clickhouse /docker-entrypoint-initdb.d

EXPOSE 9000 8123 9009
VOLUME /var/lib/clickhouse

RUN setcap cap_sys_nice,cap_net_admin,cap_ipc_lock=+ep /usr/bin/clickhouse

USER clickhouse

ENTRYPOINT ["/entrypoint.sh"]
