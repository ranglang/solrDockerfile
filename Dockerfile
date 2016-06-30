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
RUN mkdir -p /opt/solr/server/solr/lib /opt/solr/server/solr/mycores 
RUN sed -i -e 's/#SOLR_PORT=8983/SOLR_PORT=8983/' /opt/solr/bin/solr.in.sh && \
  sed -i -e '/-Dsolr.clustering.enabled=true/ a SOLR_OPTS="$SOLR_OPTS -Dsun.net.inetaddr.ttl=60 -Dsun.net.inetaddr.negative.ttl=60"' /opt/solr/bin/solr.in.sh
RUN ./bin/solr -p 8983
RUN ./bin/solr create -c zuijin
