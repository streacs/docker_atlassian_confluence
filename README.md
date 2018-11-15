# Docker - Atlassian Confluence

This is a Docker-Image for Atlassian Confluence based on Debian 9.

## Getting started
Run Atlassian Confluence standalone and navigate to `http://[dockerhost]:8090` to finish configuration:

```bash
docker run -ti -e ORACLE_JAVA_EULA=accepted -p 8090:8090 -p 8091:8091 streacs/atlassian-confluence:x.x.x
```

## Environment Variables
* (M) ORACLE_JAVA_EULA = accepted
* (O) JVM_ARGUMENTS =
* (I) SYSTEM_USER = confluence
* (I) SYSTEM_GROUP = confluence
* (I) SYSTEM_HOME = /home/confluence
* (I) APPLICATION_INST = /opt/atlassian/confluence
* (I) APPLICATION_HOME = /var/opt/atlassian/application-data/confluence
* (O) TOMCAT_PROXY_NAME = www.example.com
* (O) TOMCAT_PROXY_PORT = 80|443
* (O) TOMCAT_PROXY_SCHEME = http|https
* (O) TOMCAT_PROXY_SECURE = false|true
* (O) JVM_MEMORY_MIN = 1024m
* (O) JVM_MEMORY_MAX = 2048m

(M) = Mandatory / (O) = Optional / (I) Information

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

## Examples

Modify JVM memory
```bash
docker run -ti -e ORACLE_JAVA_EULA=accepted -p 8090:8090 -p 8091:8091 -e JVM_MEMORY_MIN=1024m -e JVM_MEMORY_MAX=2048m streacs/atlassian-confluence:x.x.x
```

Persist application data
```bash
docker run -ti -e ORACLE_JAVA_EULA=accepted -p 8090:8090 -p 8091:8091 -v CONFLUENCE-DATA:/var/opt/atlassian/application-data/confluence streacs/atlassian-confluence:x.x.x
```

## Databases

This image doesn't include the MySQL JDBC driver.
Please use PostgreSQL.

## Source Code
[Github](https://github.com/streacs/docker_atlassian_confluence)

## License
This project is licensed under the MIT License - see the [LICENSE.md](LICENSE.md) file for details