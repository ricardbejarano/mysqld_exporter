FROM golang:1-alpine AS build

ARG VERSION="0.16.0"
ARG CHECKSUM="60227efafe6cbb5e8de67f3254f31be7e99f3922f7474cf242aa79f9e90472e3"

ADD https://github.com/prometheus/mysqld_exporter/archive/v$VERSION.tar.gz /tmp/mysqld_exporter.tar.gz

RUN [ "$(sha256sum /tmp/mysqld_exporter.tar.gz | awk '{print $1}')" = "$CHECKSUM" ] && \
    apk add ca-certificates curl make && \
    tar -C /tmp -xf /tmp/mysqld_exporter.tar.gz && \
    mkdir -p /go/src/github.com/prometheus && \
    mv /tmp/mysqld_exporter-$VERSION /go/src/github.com/prometheus/mysqld_exporter && \
    cd /go/src/github.com/prometheus/mysqld_exporter && \
      make build

RUN mkdir -p /rootfs/bin && \
      cp /go/src/github.com/prometheus/mysqld_exporter/mysqld_exporter /rootfs/bin/ && \
    mkdir -p /rootfs/etc && \
      echo "nogroup:*:10000:nobody" > /rootfs/etc/group && \
      echo "nobody:*:10000:10000:::" > /rootfs/etc/passwd && \
    mkdir -p /rootfs/etc/ssl/certs && \
      cp /etc/ssl/certs/ca-certificates.crt /rootfs/etc/ssl/certs/


FROM scratch

COPY --from=build --chown=10000:10000 /rootfs /

USER 10000:10000
EXPOSE 9104/tcp
ENTRYPOINT ["/bin/mysqld_exporter"]
