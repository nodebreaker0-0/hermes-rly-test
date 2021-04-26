#!/bin/bash
    hermes -c config.toml tx raw ft-transfer chain-b chain-a transfer channel-0 99 1000 -n 4 -d stake
    hermes -c config.toml tx raw ft-transfer chain-c chain-a transfer channel-1 99 1000 -n 4 -d stake
    hermes -c config.toml tx raw ft-transfer chain-d chain-a transfer channel-2 99 1000 -n 4 -d stake
    hermes -c config.toml tx raw ft-transfer chain-e chain-a transfer channel-3 99 1000 -n 4 -d stake
    hermes -c config.toml tx raw ft-transfer chain-f chain-a transfer channel-4 99 1000 -n 4 -d stake
    hermes -c config.toml tx raw ft-transfer chain-g chain-a transfer channel-5 99 1000 -n 4 -d stake
    hermes -c config.toml tx raw ft-transfer chain-h chain-a transfer channel-6 99 1000 -n 4 -d stake
    hermes -c config.toml tx raw ft-transfer chain-i chain-a transfer channel-7 99 1000 -n 4 -d stake
    hermes -c config.toml tx raw ft-transfer chain-j chain-a transfer channel-8 99 1000 -n 4 -d stake
    hermes -c config.toml tx raw ft-transfer chain-a chain-b transfer channel-0 99 10000 -n 100 -d atom
    hermes -c config.toml tx raw ft-transfer chain-a chain-c transfer channel-0 99 1000 -n 100 -d iris
    hermes -c config.toml tx raw ft-transfer chain-a chain-d transfer channel-0 99 1000 -n 100 -d test
    hermes -c config.toml tx raw ft-transfer chain-a chain-e transfer channel-0 99 1000 -n 100 -d stake
    hermes -c config.toml tx raw ft-transfer chain-a chain-f transfer channel-0 99 1000 -n 100 -d stake
    hermes -c config.toml tx raw ft-transfer chain-a chain-g transfer channel-0 99 1000 -n 100 -d stake
    hermes -c config.toml tx raw ft-transfer chain-a chain-h transfer channel-0 99 1000 -n 100 -d stake
    hermes -c config.toml tx raw ft-transfer chain-a chain-i transfer channel-0 99 1000 -n 100 -d stake
    hermes -c config.toml tx raw ft-transfer chain-a chain-j transfer channel-0 99 1000 -n 100 -d stake

    hermes -c config.toml tx raw packet-recv chain-b chain-a transfer channel-0
    hermes -c config.toml tx raw packet-ack chain-b chain-a transfer channel-0
    hermes -c config.toml query packet unreceived-packets chain-a chain-b transfer channel-0
    hermes -c config.toml query packet unreceived-acks chain-a chain-b transfer channel-0