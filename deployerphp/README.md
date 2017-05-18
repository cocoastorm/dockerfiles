# deployerphp

Docker image for [Deployer](https://deployer.org)

## Usage
It may help to have certain ssh options set explicitly. Using Deployer's native functions...

+ `UserKnownHostsFile`
+ `StrictHostKeyChecking`

``` php
host('domain.com')
    ->user('name')
    ->port(22)
    ->configFile('~/.ssh/config')
    ->identityFile('~/.ssh/id_rsa')
    ->forwardAgent(true)
    ->multiplexing(true)
    ->addSshOption('UserKnownHostsFile', '/dev/null')
    ->addSshOption('StrictHostKeyChecking', 'no');
```

Deployer needs your `deploy.php` file and if you're using SSH your identity file.
Easiest way is to mount both of these files to the Docker container.

``` bash
docker run \
-v ~/.ssh/id_rsa:/root/.ssh/id_rsa \
-v /path/to/deploy.php:/deploy.php \
khoanguyent/deployerphp \
deploy
```