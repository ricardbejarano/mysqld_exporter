<p align="center"><img src="https://emojipedia-us.s3.dualstack.us-west-1.amazonaws.com/thumbs/320/apple/198/fire-extinguisher_1f9ef.png" width="120px"></p>
<h1 align="center">mysqld_exporter (container image)</h1>
<p align="center">Minimal container image of Prometheus' <a href="https://github.com/prometheus/mysqld_exporter">mysqld_exporter</a></p>


## Tags

### Docker Hub

Available on [Docker Hub](https://hub.docker.com) as [`ricardbejarano/mysqld_exporter`](https://hub.docker.com/r/ricardbejarano/mysqld_exporter):

- [`0.12.1`, `master`, `latest` *(Dockerfile)*](https://github.com/ricardbejarano/mysqld_exporter/blob/master/Dockerfile)

### Quay

Available on [Quay](https://quay.io) as [`quay.io/ricardbejarano/mysqld_exporter`](https://quay.io/repository/ricardbejarano/mysqld_exporter):

- [`0.12.1`, `master`, `latest` *(Dockerfile)*](https://github.com/ricardbejarano/mysqld_exporter/blob/master/Dockerfile)


## Features

* Super tiny (about `14.8MB`)
* Binary pulled from official sources during build time
* Built `FROM scratch`, with zero bloat (see [Filesystem](#filesystem))
* Reduced attack surface (no shell, no UNIX tools, no package manager...)
* Runs as unprivileged (non-`root`) user


## Building

```bash
docker build -t mysqld_exporter .
```


## Filesystem

```
/
├── mysqld_exporter
└── etc/
    ├── group
    └── passwd
```


## License

See [LICENSE](https://github.com/ricardbejarano/mysqld_exporter/blob/master/LICENSE).
