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
# reverse proxy settings

CROWD_PROXY_NAME - the host name if using a reverse proxy
CROWD_PROXY_PORT - the port if using a reverse proxy

# Postgres database settings - if set will configure a Postgres database backend for CrowdID 

CROWDID_POSTGRES_HOST - Postgres host
CROWDID_POSTGRES_PORT - Postgres port
CROWDID_POSTGRES_USER - Postgres user
CROWDID_POSTGRES_PASSWORD - Postgres password
CROWDID_POSTGRES_DATABASE - database name

# Add an SMTP SSL certificate if needed (eg. for smtp.gmail.com)
CROWD_SMTP_SSL_CERT - container's path to the certificate (should be mounted as a volume)
CROWD_SMTP_SSL_HOST - host name associated with the certificate
```
