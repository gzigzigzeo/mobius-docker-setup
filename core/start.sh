#!/usr/bin/env bash
set -o errexit
set -o pipefail

export STELLAR_HOME="/opt/stellar-core"
export STELLAR_CONFIG="$STELLAR_HOME/etc/stellar-core.cfg"

function main() {
	echo "stellar-core"
	echo ""
	echo "network: $NETWORK"

	init
  start
}

function copy_defaults() {
  cp $STELLAR_HOME/etc/default/$NETWORK/stellar-core.cfg $STELLAR_CONFIG
	echo "copy_defaults: ok"
}

function init() {
  cd $STELLAR_HOME

 	cat $STELLAR_HOME/etc/default/$NETWORK/stellar-core.cfg | envsubst > $STELLAR_CONFIG

	if db_empty; then
		echo "newdb: ok"
	  stellar-core --newdb --conf $STELLAR_CONFIG
	fi

	if [[ ! -e "/var/stellar-core/$NETWORK/history-cache/vs/.well-known/stellar-history.json" ]]; then
	  echo "newhist: ok"
	  stellar-core --newhist local --conf $STELLAR_CONFIG
	fi

  echo "init: ok"
}

function start() {
  echo "starting..."
  cd $STELLAR_HOME
	exec stellar-core --conf $STELLAR_CONFIG
}

function db_empty() {
	psql "$STELLAR_CORE_DATABASE" -c "\dt" | grep "No relations" > /dev/null
}

main "$@"
