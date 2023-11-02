

## Errors about PostgreSQL database

In ```restore_gitlab_backup.sh```, the following command might print error information about PostgreSQL database:


```
docker exec -it ${CONTAINER_NAME} gitlab-rake gitlab:backup:restore BACKUP=/var/opt/gitlab/backups/$(basename $backup_file_tar_prefix)
```

The error information is:

```
Restoring PostgreSQL database gitlabhq_production ... ERROR:  must be owner of extension pg_trgm
ERROR:  must be owner of extension btree_gist
ERROR:  must be owner of extension btree_gist
ERROR:  must be owner of extension pg_trgm
```

To fix it manually, we can: (The solution below might not be good enough, however it works for now)
 
1. stop running the script ```restore_gitlab_backup.sh```

2. source the variables to make the procedures below simple:

```
source variables.sh
```

3. modify ```postgresql.conf```

```
sudo vim ${GITLAB_HOME}/data/postgresql/data/postgresql.conf
```

as beblow (listen to all, while the default option is listen to localhost):

```
listen_addresses = '*'
```

4. modify ```pg_hba.conf```

```
sudo vim ${GITLAB_HOME}/data/postgresql/data/pg_hba.conf
```

append the following two lines at the end:
```
local   all         all                               trust
host    all         all                               127.0.0.1/32 trust
```

5. restart gitlab

```
docker exec -it ${CONTAINER_NAME} gitlab-ctl restart
```

6. log into a shell inside the container, 

```
docker exec -it ${CONTAINER_NAME} /bin/bash
```

and then run in the container:
```
$ su - gitlab-psql  # switch to user gitlab-psql

# then run the interactive command: psql.
# we need input two lines after start the command.
# the first line is  "ALTER USER gitlab WITH SUPERUSER;"
# the second line is "\q"
#
# The total command and input/output are like below:

$ /opt/gitlab/embedded/bin/psql -h 127.0.0.1 gitlabhq_production

 
gitlabhq_production=# ALTER USER gitlab WITH SUPERUSER;
 
ALTER ROLE
 
gitlabhq_production=# \q


# then exit
$ exit
```

7. Then rerun ```restore_gitlab_backup.sh```



