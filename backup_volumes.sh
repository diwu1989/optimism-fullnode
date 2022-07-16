#!/bin/bash
if [ "$EUID" -ne 0 ]
  then echo "Please run as root"
  exit
fi

export GETH_SNAPSHOT="/tmp/op-replica_geth-$(date -I).tar.zst"
echo "Archiving geth volume to $GETH_SNAPSHOT"
(
  cd /var/lib/docker/volumes/op-replica_geth/_data
  tar --zstd -cvf "$GETH_SNAPSHOT" geth
)

export DTL_SNAPSHOT="/tmp/op-replica_dtl-$(date -I).tar.zst"
echo "Archiving dtl volume to $DTL_SNAPSHOT"
(
  cd /var/lib/docker/volumes/op-replica_dtl/_data
  tar --zstd -cvf "$DTL_SNAPSHOT" .
)

ls -alh "$DTL_SNAPSHOT" "$GETH_SNAPSHOT"
