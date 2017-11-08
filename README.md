# stellar-core-horizon

Create database `core`, `horizon` and `bifrost`.

`cp .env.sample .env`

`docker-compose up`

# etherum

`docker run -it -p 8545:8545 -p 30303:30303 ethereum/client-go:alpine --testnet`

# bitcoin

`docker run -d --rm --name bitcoind -v bitcoin-data:/data amacneil/bitcoin bitcoind -testnet`

# bifrost

hm
