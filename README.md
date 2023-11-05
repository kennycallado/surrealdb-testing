
## NOTES:

- lab_users and project_users
  - before create a project_user check if already exists...
  - email unique
  - created no change on merge

- mantener tablas privadas y exponer views
``` surql
DEFINE TABLE public_users AS SELECT id, name, email, role FROM users;
```

## server

``` bash
surreal start memory --no-banner -A --auth --user root --pass root
```

## sql

``` bash
surreal sql -u root -p root --pretty --namespace test --database base
```

## import

### init file
``` bash
surreal import -u root -p root -e http://127.0.0.01:8000/rcp \
    --namespace test --database base \
    init.surql
```

### every define
``` bash
for i in `ls -d */`;do
cd $i;
surreal import -u root -p root -e http://127.0.0.01:8000/rcp \
    --namespace test --database base \
    define.surql
cd ..;
done

cd users;
surreal import -u root -p root -e http://127.0.0.01:8000/rcp \
    --namespace test --database base \
    scope.surql;
cd ..;
```
