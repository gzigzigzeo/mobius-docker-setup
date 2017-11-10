#!/usr/bin/env bash

set -o errexit
set -o pipefail

set -o allexport
: ${DATABASE_URL:="postgres://$HORIZON_DATABASE"}
: ${STELLAR_CORE_DATABASE_URL:="postgres://$STELLAR_CORE_DATABASE"}
: ${STELLAR_CORE_URL:="http://core:11626"}
set +o allexport

function db_empty() {
  psql "$1" -c "\dt" | grep "No relations" > /dev/null
}

echo "stellar-horizon"

if db_empty "$HORIZON_DATABASE"; then
  echo "db init: ok"
  horizon db init
fi

echo "starting..."
exec horizon
