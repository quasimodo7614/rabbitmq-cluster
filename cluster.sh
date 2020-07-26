#!/bin/bash

(sleep 60
h=`hostname`
# for test this was executed
if [ $h = "rabbitmq-cluster-0" ]; then
	echo this is master
else
	echo this is slave
	rabbitmqctl stop_app
	rabbitmqctl reset
	rabbitmqctl join_cluster rabbit@rabbitmq-cluster-0.rabbitmq-cluster.$POD_NAMESPACE.svc.cluster.local
	rabbitmqctl start_app
fi
) &
