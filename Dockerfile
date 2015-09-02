# http://marceldegraaf.net/2014/05/05/coreos-follow-up-sinatra-logstash-elasticsearch-kibana.html
# Marcel de Graaf <mail@marceldegraaf.net>
FROM ubuntu:14.04
MAINTAINER Nicolas Borboën <nicolas.borboen@epfl.ch>

# Install Java
RUN DEBIAN_FRONTEND=noninteractive apt-get update
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y --force-yes openjdk-7-jre-headless wget

# Install Elasticsearch
RUN mkdir -p /opt/elasticsearch

# Elasticsearch 1.7.1
RUN wget https://download.elastic.co/elasticsearch/elasticsearch/elasticsearch-1.7.1.tar.gz -O /tmp/elasticsearch-1.7.1.tar.gz
RUN tar xfz /tmp/elasticsearch-1.7.1.tar.gz -C /opt/elasticsearch --strip-components=1

# Install plugins
RUN /opt/elasticsearch/bin/plugin -install lmenezes/elasticsearch-kopf
RUN /opt/elasticsearch/bin/plugin -url http://download.elasticsearch.org/kibana/kibana/kibana-latest.zip -install elasticsearch/kibana3

# Expose port 9200
EXPOSE 9200

# Start Elasticsearch
CMD /opt/elasticsearch/bin/elasticsearch
