#!/bin/bash

set -e

SERVER_XML=${CROWD_INSTALL_DIR}/current/apache-tomcat/conf/server.xml
TARGET_CROWD_XML=${CROWD_INSTALL_DIR}/current/apache-tomcat/conf/Catalina/localhost/crowd.xml
CROWDID_JDBC_PROPERTIES=${CROWD_INSTALL_DIR}/current/crowd-openidserver-webapp/WEB-INF/classes/jdbc.properties
CROWDID_OPENIDSERVER_XML=${CROWD_INSTALL_DIR}/current/apache-tomcat/conf/Catalina/localhost/openidserver.xml

if [ "${CROWD_PROXY_NAME}" != "" -a "${CROWD_PROXY_PORT}" != "" ]
then
  sed "s/PROXY_SETTINGS/proxyName=\"${CROWD_PROXY_NAME}\" proxyPort=\"${CROWD_PROXY_PORT}\"/g" </crowd-server.xml >${SERVER_XML}
fi

if [ "${CROWDID_POSTGRES_HOST}" != "" \
  -a "${CROWDID_POSTGRES_PORT}" != "" \
  -a "${CROWDID_POSTGRES_USER}" != "" \
  -a "${CROWDID_POSTGRES_PASSWORD}" != "" \
  -a "${CROWDID_POSTGRES_DATABASE}" != "" ]
then
  sed \
    -e "s/CROWDID_POSTGRES_HOST/${CROWDID_POSTGRES_HOST}/g" \
    -e "s/CROWDID_POSTGRES_PORT/${CROWDID_POSTGRES_PORT}/g" \
    -e "s/CROWDID_POSTGRES_USER/${CROWDID_POSTGRES_USER}/g" \
    -e "s/CROWDID_POSTGRES_PASSWORD/${CROWDID_POSTGRES_PASSWORD}/g" \
    -e "s/CROWDID_POSTGRES_DATABASE/${CROWDID_POSTGRES_DATABASE}/g" \
    </crowdid-postgres-openidserver.xml >${CROWDID_OPENIDSERVER_XML}
  cp /crowdid-postgres-jdbc.properties ${CROWDID_JDBC_PROPERTIES}
fi

if [ "${CROWD_SMTP_SSL_CERT}" != "" -a "${CROWD_SMTP_SSL_HOST}" != "" ]
then
  echo yes | keytool -import -alias ${CROWD_SMTP_SSL_HOST} -keystore ${JAVA_HOME}/jre/lib/security/cacerts -file ${CROWD_SMTP_SSL_CERT} -storepass changeit
fi

if [ "${CROWD_XML}" != "" ]
then
  cp ${CROWD_XML} ${TARGET_CROWD_XML}
fi

chown -R ${CROWD_USER}:${CROWD_GROUP} ${CROWD_HOME}
su ${CROWD_USER} -c "$@"
