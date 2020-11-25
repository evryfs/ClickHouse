FROM ubuntu:20.04

ARG gosu_ver=1.10

COPY bin/clickhouse* /usr/bin/
RUN useradd clickhouse -s /bin/bash

RUN mkdir -p /etc/clickhouse-client/config.d /etc/clickhouse-server/{config.d,users.d} && \
    mkdir -p /var/lib/clickhouse /var/log/clickhouse

COPY config/config.xml /etc/clickhouse-server/
COPY config/users.xml /etc/clickhouse-server/
COPY config/docker_related_config.xml /etc/clickhouse-server/config.d/
COPY config/clickhouse.limits /etc/security/limits.d/clickhouse.conf
COPY config/clickhouse-client.xml /etc/clickhouse-client/config.xml

RUN locale-gen en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8
ENV TZ Europe/Oslo

RUN mkdir /docker-entrypoint-initdb.d
COPY entrypoint.sh /entrypoint.sh
ADD https://github.com/tianon/gosu/releases/download/$gosu_ver/gosu-amd64 /bin/gosu

RUN chmod +x /entrypoint.sh /bin/gosu
RUN chown -R clickhouse:clickhouse /etc/clickhouse-client \
    /etc/clickhouse-server /var/lib/clickhouse /var/log/clickhouse

EXPOSE 9000 8123 9009
VOLUME /var/lib/clickhouse

ENV CLICKHOUSE_CONFIG /etc/clickhouse-server/config.xml

USER clickhouse

ENTRYPOINT ["/entrypoint.sh"]
