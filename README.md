# hermes-rly-test
It was tested in a backend daemon environment for about a day.(Not dying)

We found some problems with the transfer and query section, but it is not fatal.

Also, the ability to link chains using raw transactions worked perfectly.

## Gaia setting
   ```shell
gaiad start --home chain/a/
gaiad start --home chain/b/
gaiad start --home chain/c/
gaiad start --home chain/d/
   ```
## KEY setting (keyfile: "$HOME/.hermes")
   ```shell
hermes -c config.toml keys add chain-a -f chain/a/key_seed.json 
hermes -c config.toml keys add chain-b -f chain/b/key_seed.json 
hermes -c config.toml keys add chain-c -f chain/c/key_seed.json 
hermes -c config.toml keys add chain-d -f chain/d/key_seed.json 
   ```

## multiple Chain (Concurrent packet relaying on multiple paths)
WARNING: Relaying packets concurrently over multiple channels with the start-multi command is currently experimental. Use at your own risk.
Caveat: At the moment, start-multi does not clear pending packets when starting. It is therefore advised to only use it for channels which do not have pending packets.

   ```shell
hermes -c config.toml create channel chain-a chain-b --port-a transfer --port-b transfer -o unordered
hermes -c config.toml create channel chain-a chain-c --port-a transfer --port-b transfer -o unordered
hermes -c config.toml create channel chain-a chain-d --port-a transfer --port-b transfer -o unordered
hermes -c config.toml create channel chain-b chain-c --port-a transfer --port-b transfer -o unordered
hermes -c config.toml start-multi

hermes -c config.toml query connection end chain-a connection-0
hermes -c config.toml query connection end chain-a connection-1
hermes -c config.toml query connection end chain-a connection-2

hermes -c config.toml query connection end chain-b connection-0
hermes -c config.toml query connection end chain-b connection-1

hermes -c config.toml query connection end chain-c connection-0
hermes -c config.toml query connection end chain-c connection-1

hermes -c config.toml query connection end chain-d connection-0


hermes -c config.toml query channel end chain-a transfer channel-0
hermes -c config.toml query channel end chain-a transfer channel-1
hermes -c config.toml query channel end chain-a transfer channel-1

hermes -c config.toml query channel end chain-b transfer channel-0
hermes -c config.toml query channel end chain-b transfer channel-1

hermes -c config.toml query channel end chain-c transfer channel-0
hermes -c config.toml query channel end chain-c transfer channel-1

hermes -c config.toml query channel end chain-d transfer channel-0
   ```


## Strange operation(send token)

In transfer below, it appears that there is no chain-dependent channel filtering.
The actual amount at A disappeared, but the amount did not come in from the C chain.
Configuration that should not be relayed, but currently seems to be relayable

   ```shell
hermes -c config.toml tx raw ft-transfer chain-c chain-a transfer channel-0 9999 1000 -n 1 -d stake
   ```
## Strange operation(query)

In all queries below, it appears that there is no chain-dependent channel filtering.
"Success: []" thrown when query results should not be released
   ```shell
hermes -c config.toml query packet unreceived-packets chain-a chain-b transfer channel-0
hermes -c config.toml query packet unreceived-packets chain-a chain-b transfer channel-1
hermes -c config.toml query packet unreceived-packets chain-a chain-c transfer channel-0
hermes -c config.toml query packet unreceived-packets chain-a chain-c transfer channel-1
hermes -c config.toml query packet unreceived-packets chain-a chain-d transfer channel-0

hermes -c config.toml query packet unreceived-packets chain-b chain-a transfer channel-0
hermes -c config.toml query packet unreceived-packets chain-b chain-a transfer channel-1
hermes -c config.toml query packet unreceived-packets chain-b chain-a transfer channel-2
hermes -c config.toml query packet unreceived-packets chain-b chain-c transfer channel-0
hermes -c config.toml query packet unreceived-packets chain-b chain-c transfer channel-1
hermes -c config.toml query packet unreceived-packets chain-b chain-d transfer channel-0


hermes -c config.toml query packet unreceived-packets chain-c chain-a transfer channel-0
hermes -c config.toml query packet unreceived-packets chain-c chain-a transfer channel-1
hermes -c config.toml query packet unreceived-packets chain-c chain-a transfer channel-2
hermes -c config.toml query packet unreceived-packets chain-c chain-b transfer channel-0
hermes -c config.toml query packet unreceived-packets chain-c chain-b transfer channel-1
hermes -c config.toml query packet unreceived-packets chain-c chain-d transfer channel-0

hermes -c config.toml query packet unreceived-packets chain-d chain-a transfer channel-0
hermes -c config.toml query packet unreceived-packets chain-d chain-a transfer channel-1
hermes -c config.toml query packet unreceived-packets chain-d chain-a transfer channel-2
hermes -c config.toml query packet unreceived-packets chain-d chain-b transfer channel-0
hermes -c config.toml query packet unreceived-packets chain-d chain-b transfer channel-1
hermes -c config.toml query packet unreceived-packets chain-d chain-c transfer channel-0
hermes -c config.toml query packet unreceived-packets chain-d chain-c transfer channel-1


hermes -c config.toml query packet unreceived-acks chain-a chain-b transfer channel-0
hermes -c config.toml query packet unreceived-acks chain-a chain-b transfer channel-1
hermes -c config.toml query packet unreceived-acks chain-a chain-c transfer channel-0
hermes -c config.toml query packet unreceived-acks chain-a chain-c transfer channel-1
hermes -c config.toml query packet unreceived-acks chain-a chain-d transfer channel-0
   ```



