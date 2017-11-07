#! /usr/bin/env bash
set -e

export BIFROST_HOME="/opt/bifrost"
export BIFROST_CONFIG="$STELLAR_HOME/etc/bifrost.cfg"
export BIFROST_BIN=bifrost

function main() {
	echo "bifrost"
	echo ""
	echo "network: $NETWORK"

	copy_defaults
	init
  start
}

function copy_defaults() {
  cp $BIFROST_HOME/etc/default/$NETWORK/stellar-core.cfg $BIFROST_CONFIG
	echo "copy_defaults: ok"
}

function init() {
  cd $BIFROST_HOME

 	rpl __DATABASE_URL__ "$BIFROST_DATABASE_URL" $BIFROST_CONFIG > /dev/null 2>&1

  echo "init: ok"
}

function start() {
  echo "starting..."
  cd $BIFROST_HOME
	exec $BIFROST_BIN --debug --config $BIFROST_CONFIG
}

main $@
