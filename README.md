# stellar-core-horizon

Create database `core` and `horizon`.

# stellar-core

`
docker build -t mobius/stellar-core stellar-core
docker run --env DATABASE_URL="dbname=core host=192.168.1.100 user=gzigzigzeo" --rm -it mobius/stellar-core
`

# stellar-horizon

# etherum

`docker run -it -p 8545:8545 -p 30303:30303 ethereum/client-go:alpine --testnet`

# bitcoin

`docker run -d --rm --name bitcoind -v bitcoin-data:/data amacneil/bitcoin bitcoind -testnet`

# bifrost
