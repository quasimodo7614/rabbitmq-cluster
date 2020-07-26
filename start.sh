#!/bin/sh

mkdir -p /etc/rabbitmq

/cluster.sh
#ENCFG="/etc/rabbitmq/enabled_plugins"
#if [ ! -f "$ENCFG" ]; then touch $ENCFG; fi
#echo "[rabbitmq_management,rabbitmq_peer_discovery_consul]." >> $ENCFG
DEFCFG="/etc/rabbitmq/rabbitmq.conf"
if [ ! -f "$DEFCFG" ]; then
  touch $DEFCFG
  echo "cluster_formation.k8s.address_type = hostname" >> $DEFCFG
  echo "cluster_formation.node_cleanup.interval = 60" >> $DEFCFG
  echo "cluster_formation.node_cleanup.only_log_warning = true" >> $DEFCFG
  echo "cluster_partition_handling = autoheal" >> $DEFCFG
  echo "queue_master_locator=min-masters" >> $DEFCFG
  echo "loopback_users.guest = false" >> $DEFCFG
  echo "mnesia_table_loading_retry_timeout = 60000" >> $DEFCFG
  echo "mnesia_table_loading_retry_limit = 15" >> $DEFCFG
fi


docker-entrypoint.sh rabbitmq-server
