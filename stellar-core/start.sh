#! /usr/bin/env bash
set -e

export STELLAR_HOME="/opt/stellar-core"
export STELLAR_CONFIG="$STELLAR_HOME/etc/stellar-core.cfg"
export STELLAR_BIN=/usr/local/bin/stellar-core

function main() {
	echo "stellar-core"
	echo ""
	echo "network: $NETWORK"

	copy_defaults
	init
  start
}

function copy_defaults() {
  cp $STELLAR_HOME/etc/default/$NETWORK/stellar-core.cfg $STELLAR_CONFIG
	echo "copy_defaults: ok"
}

function init() {
  cd $STELLAR_HOME

 	rpl __DATABASE_URL__ "$CORE_DATABASE_URL" $STELLAR_CONFIG > /dev/null 2>&1

	if db_empty "$CORE_DATABASE_URL"; then
		echo "newdb: ok"
	  $STELLAR_BIN --newdb --conf $STELLAR_CONFIG
	fi

  echo "init: ok"
}

function start() {
  echo "starting..."
  cd $STELLAR_HOME
	exec $STELLAR_BIN --conf $STELLAR_CONFIG
}

function db_empty() {
	psql "$1" -c "\dt" | grep "No relations" > /dev/null
}

main $@
