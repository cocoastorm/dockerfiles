# apache-php-extra

Docker image based off of `php:7.1.8-apache` with extras included.

### Apache Modules Activated

+ mod_rewrite
+ mod_remoteip

### PHP Extensions Installed

+ mysqli 
+ ctype 
+ dom 
+ json 
+ xml 
+ mbstring 
+ posix 
+ xmlwriter 
+ zip 
+ pdo_sqlite 
+ pdo_pgsql 
+ pdo_mysql 
+ pcntl 
+ curl 
+ fileinfo 
+ bz2 
+ intl 
+ simplexml 
+ pgsql 
+ ftp 
+ exif 
+ gmp

#### Note about Remote IP Module
This Docker image will try to obtain the IP address of the reverse proxy container by using `getent` and the value of the `$HTTP_PROXY` environment variable.
However, if `$HTTP_PROXY_IP` is set, it will use that value instead.
