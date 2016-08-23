# Oracle  Express Edition 11g Release 2
[![](https://images.microbadger.com/badges/image/lucazz/oracle-xe.svg)](https://microbadger.com/images/lucazz/oracle-xe "Get your own image badge on microbadger.com")
This **Dockerfile** is a [trusted build](https://registry.hub.docker.com/u/lucazz/oracle-xe/) of [Docker Registry](https://registry.hub.docker.com/).

## Using this container:
```
docker pull lucazz/oracle-xe

```

## Running this container binding it's tcp/1521:
```
docker run -d -p 1521:1521 lucazz/oracle-xe
```

## Environment Variables
Enable remote access into the container
`ORACLE_ALLOW_REMOTE`: `true` or `false`

```
docker run -d -p 1521:1521 -e ORACLE_ALLOW_REMOTE=true lucazz/oracle-xe
```

In order to connect to the database, use the following setting:
```
hostname: localhost
port: 1521
sid: xe
username: system
password: oracle
```

Access credentials
```
username: SYS
password: oracle
```
and
```
username: SYSTEM
password: oracle
```

## Extending this image
Add your `sql` or `sh` into `/docker-entrypoint-initdb.d/`:

```
FROM lucazz/oracle-xe
ADD init.sql /docker-entrypoint-initdb.d/
```
