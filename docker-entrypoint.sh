#!/bin/bash

set -e

SOURCE_SERVER_XML=/crowd-server.xml
SERVER_XML=${CROWD_INSTALL_DIR}/current/apache-tomcat/conf/server.xml
if [ "${CROWD_PROXY_NAME}" != "" -a "${CROWD_PROXY_PORT}" != "" ]
then
  sed "s/PROXY_SETTINGS/proxyName=\"${CROWD_PROXY_NAME}\" proxyPort=\"${CROWD_PROXY_PORT}\"/g" <${SOURCE_SERVER_XML} >${SERVER_XML}
else
  sed "s/PROXY_SETTINGS//g" <${SOURCE_SERVER_XML} >${SERVER_XML}
fi

chown -R ${CROWD_USER}:${CROWD_GROUP} ${CROWD_HOME}
su ${CROWD_USER} -c "$@"
