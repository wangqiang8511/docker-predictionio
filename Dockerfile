FROM ubuntu:14.04

MAINTAINER Wang Qiang "wangqiang8511@gmail.com"

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update

#Install Oracle Java 7
RUN sudo apt-get install -y python-software-properties software-properties-common
RUN add-apt-repository ppa:webupd8team/java -y && \
    apt-get update && \
    echo oracle-java7-installer shared/accepted-oracle-license-v1-1 select true | /usr/bin/debconf-set-selections && \
    apt-get install -y oracle-java7-installer
ENV JAVA_HOME /usr/lib/jvm/java-7-oracle

# Install spark binary
RUN wget -O - https://s3.amazonaws.com/bigdata-thirdparty/spark/spark-1.3.1-bin-hadoop2.6.tgz | tar zx
RUN mv spark* /opt/spark

#PredictionIO
RUN wget -O - http://download.prediction.io/PredictionIO-0.9.3.tar.gz | tar zx
RUN mv PredictionIO* /opt/PredictionIO
ENV PIO_HOME /opt/PredictionIO
ENV PATH $PATH:$PIO_HOME/bin

# Add config
ADD conf/pio-env.sh /opt/PredictionIO/conf/pio-env.sh
ADD conf/hbase-site.xml /opt/PredictionIO/conf/hbase-site.xml
ADD conf/core-site.xml /opt/PredictionIO/conf/core-site.xml
ADD scripts /scripts

ENTRYPOINT ["/scripts/setup-env.sh"]
CMD ["status"]
