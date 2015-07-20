#!/bin/bash

# Replace conf with ENV
sed -i 's/ZOOKEEPER_HOSTS/'$ZOOKEEPER_HOSTS'/g' /opt/PredictionIO/conf/hbase-site.xml
sed -i 's/NAMENODE/'$NAMENODE'/g' /opt/PredictionIO/conf/core-site.xml

SPARK_MASTER=${SPARK_MASTER:-local}
MESOS_EXECUTOR_CORE=${MESOS_EXECUTOR_CORE:-0.1}
SPARK_IMAGE=${SPARK_IMAGE:-sparkmesos:lastet}
CURRENT_IP=$(hostname -i)

sed -i 's;SPARK_MASTER;'$SPARK_MASTER';g' /opt/spark/conf/spark-defaults.conf
sed -i 's;MESOS_EXECUTOR_CORE;'$MESOS_EXECUTOR_CORE';g' /opt/spark/conf/spark-defaults.conf
sed -i 's;SPARK_IMAGE;'$SPARK_IMAGE';g' /opt/spark/conf/spark-defaults.conf
sed -i 's;CURRENT_IP;'$CURRENT_IP';g' /opt/spark/conf/spark-defaults.conf

pio-shell $@
