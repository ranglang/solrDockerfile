FROM centos:7
MAINTAINER ranglan,lanziwen@outlook.com
RUN yum update -y
RUN yum install wget tar java-1.8.0-openjdk java-1.8.0-openjdk-devel lsof -y

RUN wget http://archive.apache.org/dist/lucene/solr/5.5.2/solr-5.5.2.tgz
RUN mv solr-5.5.2.tgz  /opt
WORKDIR /opt
RUN tar -zxvf solr-5.5.2.tgz
RUN mv solr-5.5.2 solr
RUN ls /opt
WORKDIR /opt/solr
ENV SOLR_USER solr
ENV SOLR_UID 8983

RUN groupadd -r -g $SOLR_UID $SOLR_USER && \
  useradd -r -u $SOLR_UID -g $SOLR_USER $SOLR_USER

RUN mkdir -p /opt/solr/server/solr/lib /opt/solr/server/solr/mycores
RUN sed -i -e 's/#SOLR_PORT=8983/SOLR_PORT=8983/' /opt/solr/bin/solr.in.sh && \
  sed -i -e '/-Dsolr.clustering.enabled=true/ a SOLR_OPTS="$SOLR_OPTS -Dsun.net.inetaddr.ttl=60 -Dsun.net.inetaddr.negative.ttl=60"' /opt/solr/bin/solr.in.sh
RUN  chown -R $SOLR_USER:$SOLR_USER /opt/solr && \
  mkdir /docker-entrypoint-initdb.d /opt/docker-solr/

COPY scripts /opt/docker-solr/scripts
RUN chown -R $SOLR_USER:$SOLR_USER /opt/docker-solr

ENV PATH /opt/solr/bin:/opt/docker-solr/scripts:$PATH

EXPOSE 8983
WORKDIR /opt/solr
USER $SOLR_USER

#ENTRYPOINT ["/opt/docker-solr/scripts/docker-entrypoint.sh"]
CMD ["solr"]
