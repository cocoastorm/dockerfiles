# Cachet Monitor (Alpine) Docker Image

## Usage
1. Check out the [cachet-monitor](https://github.com/castawaylabs/cachet-monitor) repository to make a configuration file.
2. Docker Run:

``` bash
docker run -d \
--name cachet-monitor \
-h cachet-monitor \
-v `pwd`/config.json:/config/cachet-monitor.config.json \
castawaylabs/cachet-monitor
```