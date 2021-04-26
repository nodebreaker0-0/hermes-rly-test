#!/bin/bash
    hermes -c config.toml tx raw ft-transfer chain-b chain-a transfer channel-0 99 1000 -n 4 -d stake
    hermes -c config.toml tx raw ft-transfer chain-c chain-a transfer channel-1 99 1000 -n 4 -d stake
    hermes -c config.toml tx raw ft-transfer chain-d chain-a transfer channel-2 99 1000 -n 4 -d stake
    hermes -c config.toml tx raw ft-transfer chain-a chain-b transfer channel-0 99 1000 -n 4 -d atom
    hermes -c config.toml tx raw ft-transfer chain-a chain-c transfer channel-0 99 1000 -n 4 -d iris
    hermes -c config.toml tx raw ft-transfer chain-a chain-d transfer channel-0 99 1000 -n 4 -d test
    hermes -c config.toml tx raw ft-transfer chain-b chain-c transfer channel-1 99 1000 -n 4 -d iris
    hermes -c config.toml tx raw ft-transfer chain-c chain-d transfer channel-1 99 1000 -n 4 -d test
