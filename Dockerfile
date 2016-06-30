FROM centos:7
MAINTAINER ranglan,lanziwen@outlook.com
RUN yum update -y
RUN yum install wget tar -y

RUN wget http://archive.apache.org/dist/lucene/solr/5.5.2/solr-5.5.2.tgz
RUN mv solr-5.5.2.tgz  /opt
WORKDIR /opt
RUN tar -zxvf solr-5.5.2.tgz
RUN ls /opt
WORKDIR /opt/solr-5.5.2
RUN ./bin/solr -p 8983
