#Day 1 with SQL
####The problem sql sentence
There is a sql sentence that we use to find summation of the consume item. 
```sql
SELECT 
    SUM(-amount) AS consume
FROM
    balance bl,
    users_app_mode uam,
    users u
WHERE
    timestamp between '2016-06-13 08:00:00' and '2016-06-21 08:00:00' 
    and bl.users_app_mode_id = uam.id
    and uam.user_id = u.id
    and u.id not in (select user_id from bot)
    and amount < 0
```
The above sql's running time is ...... (I didn't wait until it finished)

Let's take a look at records number.

| Tables        | Record       |
| ------------- |:------------:|
| balance       |    32,438,925|
| users_app_mode|       194,644|
| users         |       198,749|
| bot           |            20|

####After improving
The first sql is finished in 00:02:05
```sql
SELECT 
    SUM(-amount) AS consume
FROM
    (
      select * from 
      balance_logs 
      where timestamp between '2016-06-13 08:00:00' and '2016-06-21 08:00:00' 
    ) bl,
    users_app_modes uam,
    users u
WHERE 
    bl.users_app_mode_id = uam.id
    and uam.user_id = u.id
    and u.id not in (select user_id from bots)
    and amount < 0
```

The following sql is finished in 00:01:07
```sql
SELECT 
    SUM(-amount) AS consume
FROM
    (
    select *
    from balance_logs bl
    where timestamp between '2016-06-13 08:00:00' and '2016-06-21 08:00:00'
    and amount < 0
    ) bl
    join
    (
    select uam.id
    from users_app_modes uam
    join users u on uam.user_id = u.id
    where u.id not in (select user_id from bots)
    ) uam
    on bl.users_app_mode_id = uam.id
```
And, [this](http://stackoverflow.com/questions/354070/sql-join-where-clause-vs-on-clause) is the answer for this problem
