# Vault Client Docker Image

## Usage

``` bash
docker run -rm
-e "VAULT_ADDR=127.0.0.1" \
-e "VAULT_TOKEN=<token>" \
khoanguyent/vault-client \
vault <command>
```