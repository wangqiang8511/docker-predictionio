# Introduction

Dockerfiler for predictionio.

* spark: 1.4.0
* mesos: 0.22.1
* system: ubunutu 14.04

This is not full instanlation for PredictionIO. In our case, we 
will use exsiting hbase cluster, spark cluster, hdfs cluster 
and elasticsearch cluster. PredictionIO is more like driver scripts
instead of deploying everything inside it. We think in this case
different components can scale out seperately. Mesos is also installed
since the spark executor will run on mesos.

For original docker image build script for PredictionIO, please see 
[here](https://github.com/mingfang/docker-predictionio).

# How to use

Build Image

```bash
./build
```

Run pio command.

```bash
./pio status
```

Run pio with spark.


```bash
./pio-shell --with-spark
```

# Knonw Issue

When we run the spark on mesos. It is hard to pass hadoop config files to 
spark docker container. 

Our stategy now is distribute the config file to all mesos slave hosts 
with ansible and config the mesos volumes settings.

```bash
sudo ansible -vv -i plugins/inventory/ec2.py tag_cluster_clustername \
	-s -m command -a 'aws s3 cp s3://bigdata-tmp/core-site.xml /tmp/ --region us-east-1'
```

```bash
pio import --appid 3 --input s3n://bigdata-tmp/test.json \
	-- --conf "spark.mesos.executor.docker.volumes=/tmp/core-site.xml:/opt/PredictionIO/conf/core-site.xml"
```
