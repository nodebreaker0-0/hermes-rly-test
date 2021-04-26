# hermes-rly-test
Overall, if the number of msgs increased, we could see that the relayers could not broadcast packets properly.

We tested it using the -n option.

For more detailed testing, we need to develop a tool that can shoot multiple txs into both chains.

## Gaia setting
   ```shell
gaiad start --home chain/a/
gaiad start --home chain/b/
gaiad start --home chain/c/
gaiad start --home chain/d/
gaiad start --home chain/e/
gaiad start --home chain/f/
gaiad start --home chain/g/
gaiad start --home chain/h/
gaiad start --home chain/i/
gaiad start --home chain/j/
   ```
## KEY setting (keyfile: "$HOME/.hermes")
   ```shell
hermes -c config.toml keys add chain-a -f chain/a/key_seed.json 
hermes -c config.toml keys add chain-b -f chain/b/key_seed.json 
hermes -c config.toml keys add chain-c -f chain/c/key_seed.json 
hermes -c config.toml keys add chain-d -f chain/d/key_seed.json 
hermes -c config.toml keys add chain-e -f chain/e/key_seed.json 
hermes -c config.toml keys add chain-f -f chain/f/key_seed.json 
hermes -c config.toml keys add chain-g -f chain/g/key_seed.json 
hermes -c config.toml keys add chain-h -f chain/h/key_seed.json 
hermes -c config.toml keys add chain-i -f chain/i/key_seed.json 
hermes -c config.toml keys add chain-j -f chain/j/key_seed.json 
   ```

## multiple Chain (Concurrent packet relaying on multiple paths)
WARNING: Relaying packets concurrently over multiple channels with the start-multi command is currently experimental. Use at your own risk.
Caveat: At the moment, start-multi does not clear pending packets when starting. It is therefore advised to only use it for channels which do not have pending packets.

   ```shell
hermes -c config.toml create channel chain-a chain-b --port-a transfer --port-b transfer -o unordered
hermes -c config.toml create channel chain-a chain-c --port-a transfer --port-b transfer -o unordered
hermes -c config.toml create channel chain-a chain-d --port-a transfer --port-b transfer -o unordered
hermes -c config.toml create channel chain-a chain-e --port-a transfer --port-b transfer -o unordered
hermes -c config.toml create channel chain-a chain-f --port-a transfer --port-b transfer -o unordered
hermes -c config.toml create channel chain-a chain-g --port-a transfer --port-b transfer -o unordered
hermes -c config.toml create channel chain-a chain-h --port-a transfer --port-b transfer -o unordered
hermes -c config.toml create channel chain-a chain-i --port-a transfer --port-b transfer -o unordered
hermes -c config.toml create channel chain-a chain-j --port-a transfer --port-b transfer -o unordered

hermes -c config.toml start-multi

hermes -c config.toml query connection end chain-a connection-0
hermes -c config.toml query connection end chain-a connection-1
hermes -c config.toml query connection end chain-a connection-2
hermes -c config.toml query connection end chain-a connection-3
hermes -c config.toml query connection end chain-a connection-4
hermes -c config.toml query connection end chain-a connection-5
hermes -c config.toml query connection end chain-a connection-6
hermes -c config.toml query connection end chain-a connection-7
hermes -c config.toml query connection end chain-a connection-8



hermes -c config.toml query channel end chain-a transfer channel-0
hermes -c config.toml query channel end chain-a transfer channel-1
hermes -c config.toml query channel end chain-a transfer channel-2
hermes -c config.toml query channel end chain-a transfer channel-3
hermes -c config.toml query channel end chain-a transfer channel-4
hermes -c config.toml query channel end chain-a transfer channel-5
hermes -c config.toml query channel end chain-a transfer channel-6
hermes -c config.toml query channel end chain-a transfer channel-7
hermes -c config.toml query channel end chain-a transfer channel-8

   ```


## Strange operation(send token)

The command below was executed consecutively, and the relayer was stopped.

   ```shell
    hermes -c config.toml tx raw ft-transfer chain-a chain-b transfer channel-0 99 1000 -n 100 -d atom
    hermes -c config.toml tx raw ft-transfer chain-a chain-c transfer channel-0 99 1000 -n 100 -d iris
    hermes -c config.toml tx raw ft-transfer chain-a chain-d transfer channel-0 99 1000 -n 100 -d test
    hermes -c config.toml tx raw ft-transfer chain-a chain-e transfer channel-0 99 1000 -n 100 -d stake
    hermes -c config.toml tx raw ft-transfer chain-a chain-f transfer channel-0 99 1000 -n 100 -d stake
    hermes -c config.toml tx raw ft-transfer chain-a chain-g transfer channel-0 99 1000 -n 100 -d stake
    hermes -c config.toml tx raw ft-transfer chain-a chain-h transfer channel-0 99 1000 -n 100 -d stake
    hermes -c config.toml tx raw ft-transfer chain-a chain-i transfer channel-0 99 1000 -n 100 -d stake
    hermes -c config.toml tx raw ft-transfer chain-a chain-j transfer channel-0 99 1000 -n 100 -d stake
   ```
Some packets were not sent, so after querying, manually run relay manually
   ```shell
    hermes -c config.toml query packet unreceived-packets chain-a chain-b transfer channel-0
    hermes -c config.toml tx raw packet-recv chain-a chain-b transfer channel-0
   ```


