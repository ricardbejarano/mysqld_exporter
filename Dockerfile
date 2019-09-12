FROM alpine:3 AS build

ARG VERSION="0.12.1"
ARG CHECKSUM="133b0c281e5c6f8a34076b69ade64ab6cac7298507d35b96808234c4aa26b351"

ADD https://github.com/prometheus/mysqld_exporter/releases/download/v$VERSION/mysqld_exporter-$VERSION.linux-amd64.tar.gz /tmp/mysqld_exporter.tar.gz

RUN [ "$CHECKSUM" = "$(sha256sum /tmp/mysqld_exporter.tar.gz | awk '{print $1}')" ] && \
    tar -C /tmp -xf /tmp/mysqld_exporter.tar.gz && \
    mv /tmp/mysqld_exporter-$VERSION.linux-amd64 /tmp/mysqld_exporter

RUN echo "nogroup:*:100:nobody" > /tmp/group && \
    echo "nobody:*:100:100:::" > /tmp/passwd


FROM scratch

COPY --from=build --chown=100:100 /tmp/mysqld_exporter/mysqld_exporter /
COPY --from=build --chown=100:100 /tmp/group \
                                  /tmp/passwd \
                                  /etc/

USER 100:100
EXPOSE 9104/tcp
ENTRYPOINT ["/mysqld_exporter"]
