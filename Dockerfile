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
RUN wget -O - https://s3.amazonaws.com/bigdata-thirdparty/spark/spark-1.4.0-bin-hadoop2.6.tgz | tar zx
RUN mv spark* /opt/spark

#PredictionIO
RUN wget -O - http://download.prediction.io/PredictionIO-0.9.3.tar.gz | tar zx
RUN mv PredictionIO* /opt/PredictionIO
ENV PIO_HOME /opt/PredictionIO
ENV PATH $PATH:$PIO_HOME/bin

# Mesos
RUN wget https://s3.amazonaws.com/bigdata-thirdparty/mesos_cluster/mesos_0.22.1/mesos-0.22.1.deb && \
    dpkg --unpack mesos-0.22.1.deb && \
    apt-get install -f -y && \
    rm mesos-0.22.1.deb && \
    apt-get clean

# Add config
ADD conf/pio_conf/pio-env.sh /opt/PredictionIO/conf/pio-env.sh
ADD conf/pio_conf/hbase-site.xml /opt/PredictionIO/conf/hbase-site.xml
ADD conf/pio_conf/core-site.xml /opt/PredictionIO/conf/core-site.xml
ADD conf/spark_conf/spark-defaults.conf /opt/spark/conf/spark-defaults.conf
ADD conf/spark_conf/spark-env.sh /opt/spark/conf/spark-env.sh
ADD scripts /scripts

ENV HADOOP_CONF_DIR /opt/PredictionIO/conf

ENTRYPOINT ["/scripts/setup-env.sh"]
CMD ["status"]
