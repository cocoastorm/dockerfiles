# mysql-client
Docker Alpine based image with a MySQL client.

## How to Use

Run MySQL Commands or Queries
```
mysql --host=127.0.0.1 --user root --execute "CREATE DATABASE test;"
```

Import MySQL File
```
mysql --host=127.0.01 --user root database < somefile.sql
```