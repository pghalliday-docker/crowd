# crowd

To build

```
docker build --rm --tag=pghalliday/crowd .
```

To run

```
docker run -p 0.0.0.0:8095:8095 -i -t pghalliday/crowd
```

Mounts the following volume for persistent data

```
/var/atlassian/application-data/crowd
```

Set the following environment variables to configure the server

```
CROWD_PROXY_NAME - the host name if using a reverse proxy
CROWD_PROXY_PORT - the port if using a reverse proxy
```
