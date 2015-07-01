#!/bin/bash

# Replace conf with ENV
sed -i 's/ZOOKEEPER_HOSTS/'$ZOOKEEPER_HOSTS'/g' /opt/PredictionIO/conf/hbase-site.xml
sed -i 's/NAMENODE/'$NAMENODE'/g' /opt/PredictionIO/conf/core-site.xml

pio $@
