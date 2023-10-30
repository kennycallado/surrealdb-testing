
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
