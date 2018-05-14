# Docker - Atlassian Confluence

This is a Docker-Image for Atlassian Confluence based on Debian 9.

## Getting started
Run Atlassian Confluence standalone and navigate to `http://[dockerhost]:8090` to finish configuration:

```bash
docker run -ti -e ORACLE_JAVA_EULA=accepted -p 8090:8090 -p 8091:8091 streacs/atlassian-confluence:x.x.x
```

## Environment Variables
* ORACLE_JAVA_EULA
* JVM_ARGUMENTS
* SYSTEM_USER = confluence
* SYSTEM_GROUP = confluence
* SYSTEM_HOME = /home/confluence
* APPLICATION_INST = /opt/atlassian/confluence
* APPLICATION_HOME = /var/opt/atlassian/application-data/confluence
* TOMCAT_PROXY_NAME =
* TOMCAT_PROXY_PORT =
* TOMCAT_PROXY_SCHEME =
* TOMCAT_PROXY_SECURE =

## Ports
* 8090 = Default HTTP Connector
* 8091 = Synchrony Port for collaborative Editing

## Volumes
* /var/opt/atlassian/application-data/confluence

## Oracle end user license agreement
To run this container you have to accept the terms of the Oracle Java end user license agreement.
http://www.oracle.com/technetwork/java/javase/terms/license/index.html

Add following environment variable to your configuration : 
```bash
-e ORACLE_JAVA_EULA=accepted
```

## Source Code
[Github](https://github.com/streacs/docker_atlassian_confluence)

## License
This project is licensed under the MIT License - see the [LICENSE.md](LICENSE.md) file for details