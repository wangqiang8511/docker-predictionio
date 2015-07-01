# Introduction

Dockerfiler for predictionio.

* spark: 1.3.1
* system: ubunutu 14.04

This is not full instanlation for PredictionIO. In our case, we 
will use exsiting hbase cluster and spark cluster, hdfs cluster 
and elasticsearch cluster. PredictionIO is more like driver scripts
instead of deploying everything insided it. We think in this case
different components can scale out seperately.

For original docker image build script for PredictionIO, please see 
[here](https://github.com/mingfang/docker-predictionio).

# How to use

Build Image

```bash
./build
```
