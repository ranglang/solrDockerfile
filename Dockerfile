FROM centos:7
MAINTAINER ranglan,lanziwen@outlook.com
RUN yum update -y
RUN yum install wget -y
RUN wget http://archive.apache.org/dist/lucene/solr/5.5.2/solr-5.5.2.tgz /opt
