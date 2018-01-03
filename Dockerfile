##############################################################################
# Dockerfile to build Atlassian Confluence container images
# Based on Debian (https://hub.docker.com/r/_/debian/)
##############################################################################

FROM debian:stretch-slim

MAINTAINER Oliver Wolf <root@streacs.com>

ARG APPLICATION_RELEASE

ENV JAVA_VERSION_MAJOR=8
ENV JAVA_VERSION_MINOR=152
ENV JAVA_VERSION_BUILD=16
ENV JAVA_VERSION_PATH=aa0333dd3019491ca4f6ddbe78cdb6d0

ENV JAVA_HOME=/opt/jdk

ENV APPLICATION_INST /opt/atlassian/confluence
ENV APPLICATION_HOME /var/opt/atlassian/application-data/confluence

ENV SYSTEM_USER confluence
ENV SYSTEM_GROUP confluence
ENV SYSTEM_HOME /home/confluence

ENV DEBIAN_FRONTEND noninteractive

RUN set -x \
  && apt-get update \
  && apt-get -y --no-install-recommends install wget xmlstarlet ca-certificates ruby-rspec \
  && gem install serverspec

RUN set -x \
  && wget -q --no-cookies --no-check-certificate --header "Cookie: oraclelicense=accept-securebackup-cookie" -O /tmp/jdk-${JAVA_VERSION_MAJOR}u${JAVA_VERSION_MINOR}-linux-x64.tar.gz http://download.oracle.com/otn-pub/java/jdk/${JAVA_VERSION_MAJOR}u${JAVA_VERSION_MINOR}-b${JAVA_VERSION_BUILD}/${JAVA_VERSION_PATH}/jdk-${JAVA_VERSION_MAJOR}u${JAVA_VERSION_MINOR}-linux-x64.tar.gz \
  && mkdir -p ${JAVA_HOME} \
  && tar xfz /tmp/jdk-${JAVA_VERSION_MAJOR}u${JAVA_VERSION_MINOR}-linux-x64.tar.gz --strip-components=1 -C ${JAVA_HOME} \
  && update-alternatives --install /usr/bin/java java ${JAVA_HOME}/bin/java 1 \
  && rm /tmp/jdk-${JAVA_VERSION_MAJOR}u${JAVA_VERSION_MINOR}-linux-x64.tar.gz

RUN set -x \
  && addgroup --system ${SYSTEM_GROUP} \
  && adduser --system --home ${SYSTEM_HOME} --ingroup ${SYSTEM_GROUP} ${SYSTEM_USER}

RUN set -x \
  && mkdir -p ${APPLICATION_INST} \
  && mkdir -p ${APPLICATION_HOME} \
  && wget --no-check-certificate -nv -O /tmp/atlassian-confluence-${APPLICATION_RELEASE}.tar.gz https://www.atlassian.com/software/confluence/downloads/binary/atlassian-confluence-${APPLICATION_RELEASE}.tar.gz \
  && tar xfz /tmp/atlassian-confluence-${APPLICATION_RELEASE}.tar.gz --strip-components=1 -C ${APPLICATION_INST} \
  && chown -R ${SYSTEM_USER}:${SYSTEM_GROUP} ${APPLICATION_INST} \
  && chown -R ${SYSTEM_USER}:${SYSTEM_GROUP} ${APPLICATION_HOME} \
  && rm /tmp/atlassian-confluence-${APPLICATION_RELEASE}.tar.gz

RUN set -x \
  && apt-get clean \
  && rm -rf /var/cache/* \
  && rm -rf /tmp/*

ADD files/service /usr/local/bin/service
ADD files/entrypoint /usr/local/bin/entrypoint
ADD files/healthcheck /usr/local/bin/healthcheck
ADD rspec-specs ${SYSTEM_HOME}/

RUN set -x \
  && touch -d "@0" "${APPLICATION_INST}/confluence/WEB-INF/classes/confluence-init.properties" \
  && touch -d "@0" "${APPLICATION_INST}/bin/setenv.sh" \
  && touch -d "@0" "${APPLICATION_INST}/conf/server.xml"

VOLUME ${APPLICATION_HOME}

EXPOSE 8090 8091

ENTRYPOINT ["/usr/local/bin/entrypoint"]

USER ${SYSTEM_USER}

WORKDIR ${SYSTEM_HOME}

HEALTHCHECK --interval=5s --timeout=3s CMD /usr/local/bin/healthcheck

CMD ["/usr/local/bin/service"]