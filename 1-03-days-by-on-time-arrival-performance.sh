#!/usr/bin/env bash

SCRIPT_DIR=python
THIS="$(basename $0)"
THIS=${THIS/.sh}
TOPIC=ontime
KAFKA_OR_ZOOKEEPER=ip-172-30-0-211.ec2.internal:2181

spark-submit --packages org.apache.spark:spark-streaming-kafka_2.10:1.6.0 \
  --master yarn \
  --deploy-mode client \
  --driver-memory 4g \
  --driver-cores 4 \
  --executor-memory 4g \
  --num-executors 21 \
  --executor-cores 2 \
  --conf spark.task.cpus=1 \
  --conf spark.yarn.executor.memoryOverhead=1000 \
  --conf spark.default.parallelism=42 \
  --conf "spark.executor.extraJavaOptions=-XX:+UseCompressedOops" \
  --conf spark.streaming.backpressure.enabled=true \
  $SCRIPT_DIR/${THIS}.py $KAFKA_OR_ZOOKEEPER $TOPIC

#--conf spark.streaming.kafka.maxRate=300000 \
#--conf spark.streaming.receiver.maxRate=300000 \

