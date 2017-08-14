# lighttpd + php + h5ai

> Alpine Docker image with lighttpd, php, and h5ai (modern server file indexer)

## Usage
Simply mount a volume or a host directory to `/var/www/html` and bind container port 8000, like so:

``` bash
docker run -d -p 80:8000 -v /some/dir:/var/www/html khoanguyent/h5ai-lighttpd
```

### External Links

#### lighttpd

+ [Source Installation](http://redmine.lighttpd.net/projects/lighttpd/wiki/InstallFromSource)
+ [Setting up PHP with Lighttpd](http://redmine.lighttpd.net/projects/lighttpd/wiki/TutorialLighttpdAndPHP#Configuration)
+ [PHP FastCGI Configuration](https://www.cyberciti.biz/tips/lighttpd-php-fastcgi-configuration.html)
+ [Debian `lighttpd` Package](https://anonscm.debian.org/cgit/pkg-lighttpd/lighttpd.git/tree/debian)

#### h5ai - modern HTTP web server index
+ [h5ai](https://larsjung.de/h5ai)

#### php

+ [Common Compile Errors](https://www.crybit.com/20-common-php-compilation-errors-and-fix-unix)