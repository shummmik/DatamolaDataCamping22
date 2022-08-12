# Task 1

```sql
SELECT 
    TSN.NAME,
    ROW_NUMBER() OVER (ORDER BY TS.START_DTM) ROW_NUMBER,
    DENSE_RANK() OVER (ORDER BY TS.START_DTM) DENSE_RANK,
    RANK() OVER (ORDER BY TS.START_DTM) RANK,
    ROW_NUMBER() OVER (ORDER BY TS.START_DTM) - RANK() OVER (ORDER BY TS.START_DTM) NUMBER_IN_DATA,
    TS.ID_SUBSCRIPTIONS_NAME,
    TS.START_DTM,
    TS.END_DTM
    
FROM
U_DW_SUBSTRICTIONS.T_SUBSCRIPTIONS TS
INNER JOIN 
U_DW_SUBSTRICTIONS.T_SUBSCRIPTIONS_NAME TSN
ON 
TS.ID_SUBSCRIPTIONS_NAME=TSN.ID_SUBSCRIPTIONS_NAME
ORDER BY TS.START_DTM;


--NAME   |ROW_NUMBER|DENSE_RANK|RANK|NUMBER_IN_DATA|ID_SUBSCRIPTIONS_NAME|START_DTM              |END_DTM                |
---------+----------+----------+----+--------------+---------------------+-----------------------+-----------------------+
--PREMIUM|         1|         1|   1|             0|                    3|2021-02-01 00:00:00.000|2021-08-01 00:00:00.000|
--MEDIUM |         2|         1|   1|             1|                    2|2021-02-01 00:00:00.000|2021-07-31 00:00:00.000|
--YEAR   |         3|         1|   1|             2|                    4|2021-02-01 00:00:00.000|2021-08-01 00:00:00.000|
--START  |         4|         1|   1|             3|                    1|2021-02-01 00:00:00.000|2021-07-31 00:00:00.000|
--YEAR   |         5|         2|   5|             0|                    4|2021-08-01 00:00:00.000|2021-10-01 00:00:00.000|
--PREMIUM|         6|         2|   5|             1|                    3|2021-08-01 00:00:00.000|2021-10-01 00:00:00.000|
--MEDIUM |         7|         2|   5|             2|                    2|2021-08-01 00:00:00.000|2021-10-01 00:00:00.000|
--START  |         8|         2|   5|             3|                    1|2021-08-01 00:00:00.000|2021-10-01 00:00:00.000|
--PREMIUM|         9|         3|   9|             0|                    3|2021-10-02 00:00:00.000|2022-03-01 00:00:00.000|
--YEAR   |        10|         3|   9|             1|                    4|2021-10-02 00:00:00.000|                       |
--START  |        11|         3|   9|             2|                    1|2021-10-02 00:00:00.000|                       |
--MEDIUM |        12|         3|   9|             3|                    2|2021-10-02 00:00:00.000|                       |
--PREMIUM|        13|         4|  13|             0|                    3|2022-03-02 00:00:00.000|                       |
```