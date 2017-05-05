# Percona XtraBackup Docker Image
Alpine Docker Image with Percona XtraBackup v2.3.8

### Background Info
[A beautifully written tutorial by Digital Ocean](https://www.digitalocean.com/community/tutorials/how-to-configure-mysql-backups-with-percona-xtrabackup-on-ubuntu-16-04)

### Included Scripts
The included bash scripts are based on the scripts provided by the DO Tutorial. Only changes made were to remove the `backup` user check. As this isn't necessary as the docker container runs the scripts as root.

+ backup-mysql.sh
+ extract-mysql.sh
+ prepare-mysql.sh

### Creating the Backup User
Follow the tutorial in creating a `backup` user in your MySQL database, and creating the backup.cnf file storing the `backup` user's credentials into a `backup.cnf` like so:

```
[client]
user=backup
password=password
```

### Running the Provided Scripts
It's definitely possible to do this with a docker-compose.yml file. Incoming example soon tm.

#### Backing up the Database
When running backups, it'll be ideal to bind mount the `/backups/mysql` directory to a directory on the host, where you would want to store your database backups.

If your MySQL instance is hosted locally, bind mount the data directory of the MySQL instance.

``` bash
docker run --rm \
-v /var/lib/mysql:/var/lib/mysql \
-v /etc/mysql/backup.cnf:/etc/mysql/backup.cnf \
-v /home/sysadmin/backups:/backups/mysql
khoanguyent/percona \
backup-mysql.sh
```

If your MySQL instance is hosted inside a Docker container, make sure the `/var/lib/mysql` data directory is mounted as a Docker volume.
This way the Percona container can inherit the MySQL Data volume when running backups.

``` bash
docker run --rm \
-v /etc/mysql/backup.cnf:/etc/mysql/backup.cnf \
-v /home/sysadmin/backups:/backups/mysql \
--volumes-from db \
khoanguyent/percona \
backup-mysql.sh
```

NOTE: Replace `db` with the container name of your MySQL instance.
