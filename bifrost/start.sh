#! /usr/bin/env bash
set -e

export BIFROST_HOME="/opt/bifrost"
export BIFROST_CONFIG="$BIFROST_HOME/etc/bifrost.cfg"
export BIFROST_BIN=bifrost

function main() {
	echo "bifrost"
	echo ""
	echo "network: $NETWORK"

	init
  start
}

function init() {
  cd $BIFROST_HOME

	cat $BIFROST_HOME/etc/default/$NETWORK/bifrost.cfg | envsubst > $BIFROST_CONFIG

  echo "init: ok"
}

function start() {
  echo "starting..."
  cd $BIFROST_HOME
	exec $BIFROST_BIN --debug --config $BIFROST_CONFIG
}

main $@
