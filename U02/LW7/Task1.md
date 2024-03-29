# Task 1

```sql 

grant create table to U_DW_SUBSTRICTIONS;

CREATE MATERIALIZED VIEW U_DW_SUBSTRICTIONS.MONTHLY_SUBSTRICTIONS_REP
BUILD DEFERRED 
REFRESH COMPLETE  
ON DEMAND
AS select TSS.NAME SUBSCRIPTION, 
    trunc(tsuf.START_DTM, 'YYYY')      AS YEAR,
    trunc(tsuf.START_DTM, 'MM')      AS MONTH,
    SUM(tsuf.PAYMENT) AS PROFIT_BY_MOUNTH
  
    from U_DW_SUBSTRICTIONS.T_SUBSCRIPTIONS_USER_F tsuf 
    inner join 
    (SELECT *
    FROM
    U_DW_SUBSTRICTIONS.T_SUBSCRIPTIONS TS
    INNER JOIN 
    U_DW_SUBSTRICTIONS.T_SUBSCRIPTIONS_NAME TSN
    ON 
    TS.ID_SUBSCRIPTIONS_NAME=TSN.ID_SUBSCRIPTIONS_NAME)
    TSS 
    on 
    tsuf.ID_SUBSCRIPTIONS=TSS.ID_SUBSCRIPTIONS
    GROUP BY 
        TSS.NAME, 
        trunc(tsuf.START_DTM, 'YYYY'),
        trunc(tsuf.START_DTM, 'MM') 
    ORDER BY 
    SUBSCRIPTION, 
    YEAR,
    MONTH;


SELECT * FROM U_DW_SUBSTRICTIONS.MONTHLY_SUBSTRICTIONS_REP;
```

| SUBSCRIPTION | YEAR | MONTH | PROFIT\_BY\_MOUNTH |
| :--- | :--- | :--- | :--- |
| null | null | null | null |


```sql
EXEC DBMS_MVIEW.REFRESH('U_DW_SUBSTRICTIONS.MONTHLY_SUBSTRICTIONS_REP');


SELECT * FROM U_DW_SUBSTRICTIONS.MONTHLY_SUBSTRICTIONS_REP;  

```
| SUBSCRIPTION | YEAR | MONTH | PROFIT\_BY\_MOUNTH |
| :--- | :--- | :--- | :--- |
| START | 2021-01-01 00:00:00 | 2021-09-01 00:00:00 | 119443.56 |
| PREMIUM | 2021-01-01 00:00:00 | 2021-09-01 00:00:00 | 22316 |
| YEAR | 2021-01-01 00:00:00 | 2021-07-01 00:00:00 | 54935.11 |
| START | 2022-01-01 00:00:00 | 2022-07-01 00:00:00 | 7414.92 |
| PREMIUM | 2022-01-01 00:00:00 | 2022-07-01 00:00:00 | 84010.79 |
| MEDIUM | 2022-01-01 00:00:00 | 2022-07-01 00:00:00 | 42478.08 |
| PREMIUM | 2021-01-01 00:00:00 | 2021-07-01 00:00:00 | 18722.56 |
| PREMIUM | 2021-01-01 00:00:00 | 2021-10-01 00:00:00 | 26223.18 |
| YEAR | 2021-01-01 00:00:00 | 2021-09-01 00:00:00 | 258737.17 |
| START | 2021-01-01 00:00:00 | 2021-02-01 00:00:00 | 14230.57 |
| MEDIUM | 2021-01-01 00:00:00 | 2021-10-01 00:00:00 | 40056.53 |
| START | 2021-01-01 00:00:00 | 2021-10-01 00:00:00 | 7123.82 |
| PREMIUM | 2022-01-01 00:00:00 | 2022-03-01 00:00:00 | 80368.4 |
| MEDIUM | 2021-01-01 00:00:00 | 2021-02-01 00:00:00 | 9638.84 |
| YEAR | 2021-01-01 00:00:00 | 2021-08-01 00:00:00 | 270026.2 |
| MEDIUM | 2021-01-01 00:00:00 | 2021-08-01 00:00:00 | 44028.15 |
| YEAR | 2021-01-01 00:00:00 | 2021-02-01 00:00:00 | 50144.72 |
| PREMIUM | 2021-01-01 00:00:00 | 2021-02-01 00:00:00 | 16344.54 |
| PREMIUM | 2021-01-01 00:00:00 | 2021-08-01 00:00:00 | 23622.88 |
| PREMIUM | 2021-01-01 00:00:00 | 2021-11-01 00:00:00 | 26753.44 |
| START | 2021-01-01 00:00:00 | 2021-08-01 00:00:00 | 123756.73 |
| MEDIUM | 2021-01-01 00:00:00 | 2021-03-01 00:00:00 | 10870.22 |
| START | 2021-01-01 00:00:00 | 2021-03-01 00:00:00 | 15222.89 |
| YEAR | 2021-01-01 00:00:00 | 2021-03-01 00:00:00 | 56049.72 |
| MEDIUM | 2021-01-01 00:00:00 | 2021-09-01 00:00:00 | 43302.88 |
| MEDIUM | 2021-01-01 00:00:00 | 2021-11-01 00:00:00 | 41907.87 |
| PREMIUM | 2021-01-01 00:00:00 | 2021-03-01 00:00:00 | 17924.04 |
| PREMIUM | 2021-01-01 00:00:00 | 2021-04-01 00:00:00 | 17320 |
| START | 2021-01-01 00:00:00 | 2021-04-01 00:00:00 | 14889.73 |
| PREMIUM | 2022-01-01 00:00:00 | 2022-04-01 00:00:00 | 80750.82 |
| START | 2021-01-01 00:00:00 | 2021-12-01 00:00:00 | 7321.34 |
| MEDIUM | 2021-01-01 00:00:00 | 2021-12-01 00:00:00 | 41491.3 |
| MEDIUM | 2021-01-01 00:00:00 | 2021-04-01 00:00:00 | 10534.86 |
| PREMIUM | 2022-01-01 00:00:00 | 2022-05-01 00:00:00 | 84404.56 |
| YEAR | 2021-01-01 00:00:00 | 2021-04-01 00:00:00 | 53807.41 |
| MEDIUM | 2021-01-01 00:00:00 | 2021-05-01 00:00:00 | 10870.58 |
| START | 2021-01-01 00:00:00 | 2021-05-01 00:00:00 | 15270.85 |
| PREMIUM | 2022-01-01 00:00:00 | 2022-01-01 00:00:00 | 27260.05 |
| MEDIUM | 2022-01-01 00:00:00 | 2022-01-01 00:00:00 | 40506.13 |
| PREMIUM | 2021-01-01 00:00:00 | 2021-05-01 00:00:00 | 18245.19 |
| YEAR | 2021-01-01 00:00:00 | 2021-05-01 00:00:00 | 54908.59 |
| START | 2022-01-01 00:00:00 | 2022-01-01 00:00:00 | 7432.29 |
| PREMIUM | 2022-01-01 00:00:00 | 2022-06-01 00:00:00 | 80842.49 |
| MEDIUM | 2021-01-01 00:00:00 | 2021-06-01 00:00:00 | 10566.46 |
| START | 2021-01-01 00:00:00 | 2021-06-01 00:00:00 | 14575.55 |
| PREMIUM | 2021-01-01 00:00:00 | 2021-06-01 00:00:00 | 17574.45 |
| MEDIUM | 2022-01-01 00:00:00 | 2022-02-01 00:00:00 | 37365.05 |
| START | 2022-01-01 00:00:00 | 2022-02-01 00:00:00 | 6632.83 |
| YEAR | 2021-01-01 00:00:00 | 2021-06-01 00:00:00 | 53086.57 |
| PREMIUM | 2022-01-01 00:00:00 | 2022-02-01 00:00:00 | 24748.56 |
| START | 2022-01-01 00:00:00 | 2022-03-01 00:00:00 | 7243.57 |
| MEDIUM | 2022-01-01 00:00:00 | 2022-03-01 00:00:00 | 42350.61 |
| MEDIUM | 2021-01-01 00:00:00 | 2021-07-01 00:00:00 | 10408.32 |
| MEDIUM | 2022-01-01 00:00:00 | 2022-04-01 00:00:00 | 39970.61 |
| START | 2022-01-01 00:00:00 | 2022-04-01 00:00:00 | 7186.25 |
| PREMIUM | 2021-01-01 00:00:00 | 2021-12-01 00:00:00 | 27983.93 |
| MEDIUM | 2022-01-01 00:00:00 | 2022-05-01 00:00:00 | 40422.82 |
| START | 2022-01-01 00:00:00 | 2022-06-01 00:00:00 | 7224.66 |
| MEDIUM | 2022-01-01 00:00:00 | 2022-06-01 00:00:00 | 41553.66 |
| START | 2021-01-01 00:00:00 | 2021-11-01 00:00:00 | 7057.5 |
| START | 2021-01-01 00:00:00 | 2021-07-01 00:00:00 | 14939.44 |
| START | 2022-01-01 00:00:00 | 2022-05-01 00:00:00 | 7281.69 |