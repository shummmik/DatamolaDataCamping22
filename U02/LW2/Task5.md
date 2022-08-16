# Task 5

```sql

select  
trunc(START_DTM, 'YYYY')      AS YEAR,
trunc(START_DTM, 'MM')      AS MONTH,
trunc(START_DTM, 'DD')      AS DAY,
trunc(START_DTM, 'Q')      AS QUARTER,
SUM(PAYMENT) AS PROFIT_BY_MOUNTH,
DECODE(grouping(trunc(START_DTM, 'MM')), 1, 'OTHER', 'MONTH') GR_MONTH,
decode(grouping_id( trunc(START_DTM, 'YYYY'),trunc(START_DTM, 'Q'), trunc(START_DTM, 'MM'), trunc(START_DTM, 'DD')),
        15, 'ALL',
        7, 'YEAR',
        3, 'YEAR-QUARTER',
        1, 'YEAR-QUARTER-MONTH', 
        'YEAR-QUARTER-MONTH-DAY') GR_BY_hierarchy
from  U_DW_SUBSTRICTIONS.T_SUBSCRIPTIONS_USER_F 
GROUP BY ROLLUP  (
    trunc(START_DTM, 'YYYY'),
    trunc(START_DTM, 'Q') ,
    trunc(START_DTM, 'MM'),
    trunc(START_DTM, 'DD'));
    
--YEAR                   |MONTH                  |DAY                    |QUARTER                |PROFIT_BY_MOUNTH|GR_MONTH|GR_BY_HIERARCHY       |
-------------------------+-----------------------+-----------------------+-----------------------+----------------+--------+----------------------+
--2021-01-01 00:00:00.000|2021-09-01 00:00:00.000|2021-09-24 00:00:00.000|2021-07-01 00:00:00.000|        13703.85|MONTH   |YEAR-QUARTER-MONTH-DAY|
--2021-01-01 00:00:00.000|2021-10-01 00:00:00.000|2021-10-04 00:00:00.000|2021-10-01 00:00:00.000|         2515.92|MONTH   |YEAR-QUARTER-MONTH-DAY|
--2021-01-01 00:00:00.000|2021-08-01 00:00:00.000|2021-08-03 00:00:00.000|2021-07-01 00:00:00.000|        14278.97|MONTH   |YEAR-QUARTER-MONTH-DAY|
--2021-01-01 00:00:00.000|2021-08-01 00:00:00.000|2021-08-14 00:00:00.000|2021-07-01 00:00:00.000|        14051.19|MONTH   |YEAR-QUARTER-MONTH-DAY|
--2021-01-01 00:00:00.000|2021-11-01 00:00:00.000|2021-11-03 00:00:00.000|2021-10-01 00:00:00.000|         2387.52|MONTH   |YEAR-QUARTER-MONTH-DAY|
--2021-01-01 00:00:00.000|2021-03-01 00:00:00.000|2021-03-08 00:00:00.000|2021-01-01 00:00:00.000|         3097.69|MONTH   |YEAR-QUARTER-MONTH-DAY|
--2021-01-01 00:00:00.000|2021-09-01 00:00:00.000|2021-09-03 00:00:00.000|2021-07-01 00:00:00.000|        14193.16|MONTH   |YEAR-QUARTER-MONTH-DAY|
--2021-01-01 00:00:00.000|2021-11-01 00:00:00.000|2021-11-11 00:00:00.000|2021-10-01 00:00:00.000|         2508.38|MONTH   |YEAR-QUARTER-MONTH-DAY|
--2021-01-01 00:00:00.000|2021-03-01 00:00:00.000|2021-03-25 00:00:00.000|2021-01-01 00:00:00.000|         3249.39|MONTH   |YEAR-QUARTER-MONTH-DAY|
--2021-01-01 00:00:00.000|2021-09-01 00:00:00.000|2021-09-13 00:00:00.000|2021-07-01 00:00:00.000|        15357.79|MONTH   |YEAR-QUARTER-MONTH-DAY|
--2021-01-01 00:00:00.000|2021-09-01 00:00:00.000|2021-09-20 00:00:00.000|2021-07-01 00:00:00.000|        14415.66|MONTH   |YEAR-QUARTER-MONTH-DAY|
--2021-01-01 00:00:00.000|2021-04-01 00:00:00.000|2021-04-15 00:00:00.000|2021-04-01 00:00:00.000|         3319.61|MONTH   |YEAR-QUARTER-MONTH-DAY|
--2021-01-01 00:00:00.000|2021-04-01 00:00:00.000|2021-04-14 00:00:00.000|2021-04-01 00:00:00.000|         3312.61|MONTH   |YEAR-QUARTER-MONTH-DAY|
--2022-01-01 00:00:00.000|2022-05-01 00:00:00.000|2022-05-20 00:00:00.000|2022-04-01 00:00:00.000|         4349.68|MONTH   |YEAR-QUARTER-MONTH-DAY|
--2022-01-01 00:00:00.000|2022-01-01 00:00:00.000|2022-01-07 00:00:00.000|2022-01-01 00:00:00.000|         2414.18|MONTH   |YEAR-QUARTER-MONTH-DAY|
--2021-01-01 00:00:00.000|2021-06-01 00:00:00.000|2021-06-05 00:00:00.000|2021-04-01 00:00:00.000|         3089.15|MONTH   |YEAR-QUARTER-MONTH-DAY|
--2021-01-01 00:00:00.000|2021-06-01 00:00:00.000|2021-06-06 00:00:00.000|2021-04-01 00:00:00.000|          3270.5|MONTH   |YEAR-QUARTER-MONTH-DAY|
--2021-01-01 00:00:00.000|2021-06-01 00:00:00.000|2021-06-03 00:00:00.000|2021-04-01 00:00:00.000|         3138.82|MONTH   |YEAR-QUARTER-MONTH-DAY|
--2022-01-01 00:00:00.000|2022-02-01 00:00:00.000|2022-02-21 00:00:00.000|2022-01-01 00:00:00.000|          2334.2|MONTH   |YEAR-QUARTER-MONTH-DAY|
--2022-01-01 00:00:00.000|2022-02-01 00:00:00.000|2022-02-22 00:00:00.000|2022-01-01 00:00:00.000|         2469.06|MONTH   |YEAR-QUARTER-MONTH-DAY|
--2022-01-01 00:00:00.000|2022-07-01 00:00:00.000|2022-07-22 00:00:00.000|2022-07-01 00:00:00.000|         4708.74|MONTH   |YEAR-QUARTER-MONTH-DAY|
--2021-01-01 00:00:00.000|2021-10-01 00:00:00.000|2021-10-23 00:00:00.000|2021-10-01 00:00:00.000|         2483.46|MONTH   |YEAR-QUARTER-MONTH-DAY|
--2022-01-01 00:00:00.000|2022-03-01 00:00:00.000|2022-03-20 00:00:00.000|2022-01-01 00:00:00.000|         4268.34|MONTH   |YEAR-QUARTER-MONTH-DAY|
--2022-01-01 00:00:00.000|2022-03-01 00:00:00.000|2022-03-22 00:00:00.000|2022-01-01 00:00:00.000|          4515.6|MONTH   |YEAR-QUARTER-MONTH-DAY|
--2021-01-01 00:00:00.000|2021-09-01 00:00:00.000|2021-09-15 00:00:00.000|2021-07-01 00:00:00.000|        14513.13|MONTH   |YEAR-QUARTER-MONTH-DAY|
--2022-01-01 00:00:00.000|2022-04-01 00:00:00.000|2022-04-16 00:00:00.000|2022-04-01 00:00:00.000|         4239.24|MONTH   |YEAR-QUARTER-MONTH-DAY|
--2021-01-01 00:00:00.000|2021-12-01 00:00:00.000|2021-12-29 00:00:00.000|2021-10-01 00:00:00.000|         2573.95|MONTH   |YEAR-QUARTER-MONTH-DAY|
--2021-01-01 00:00:00.000|2021-09-01 00:00:00.000|2021-09-22 00:00:00.000|2021-07-01 00:00:00.000|        14712.62|MONTH   |YEAR-QUARTER-MONTH-DAY|
--2022-01-01 00:00:00.000|2022-05-01 00:00:00.000|2022-05-28 00:00:00.000|2022-04-01 00:00:00.000|          4062.2|MONTH   |YEAR-QUARTER-MONTH-DAY|
--2022-01-01 00:00:00.000|2022-06-01 00:00:00.000|2022-06-04 00:00:00.000|2022-04-01 00:00:00.000|         4339.89|MONTH   |YEAR-QUARTER-MONTH-DAY|
--2022-01-01 00:00:00.000|2022-06-01 00:00:00.000|2022-06-28 00:00:00.000|2022-04-01 00:00:00.000|         4677.72|MONTH   |YEAR-QUARTER-MONTH-DAY|
--2021-01-01 00:00:00.000|2021-11-01 00:00:00.000|2021-11-09 00:00:00.000|2021-10-01 00:00:00.000|         2488.32|MONTH   |YEAR-QUARTER-MONTH-DAY|
--2021-01-01 00:00:00.000|2021-07-01 00:00:00.000|2021-07-15 00:00:00.000|2021-07-01 00:00:00.000|          3331.1|MONTH   |YEAR-QUARTER-MONTH-DAY|
--2021-01-01 00:00:00.000|2021-07-01 00:00:00.000|2021-07-12 00:00:00.000|2021-07-01 00:00:00.000|         3274.82|MONTH   |YEAR-QUARTER-MONTH-DAY|
--2021-01-01 00:00:00.000|2021-09-01 00:00:00.000|2021-09-02 00:00:00.000|2021-07-01 00:00:00.000|        15160.02|MONTH   |YEAR-QUARTER-MONTH-DAY|
--2022-01-01 00:00:00.000|2022-01-01 00:00:00.000|2022-01-12 00:00:00.000|2022-01-01 00:00:00.000|         2657.95|MONTH   |YEAR-QUARTER-MONTH-DAY|
--2021-01-01 00:00:00.000|2021-04-01 00:00:00.000|2021-04-04 00:00:00.000|2021-04-01 00:00:00.000|         2863.22|MONTH   |YEAR-QUARTER-MONTH-DAY|
--2021-01-01 00:00:00.000|2021-04-01 00:00:00.000|2021-04-11 00:00:00.000|2021-04-01 00:00:00.000|         3262.11|MONTH   |YEAR-QUARTER-MONTH-DAY|
--2021-01-01 00:00:00.000|2021-04-01 00:00:00.000|2021-04-25 00:00:00.000|2021-04-01 00:00:00.000|         3279.51|MONTH   |YEAR-QUARTER-MONTH-DAY|
--2021-01-01 00:00:00.000|2021-10-01 00:00:00.000|2021-10-14 00:00:00.000|2021-10-01 00:00:00.000|          2281.4|MONTH   |YEAR-QUARTER-MONTH-DAY|
--2021-01-01 00:00:00.000|2021-06-01 00:00:00.000|2021-06-07 00:00:00.000|2021-04-01 00:00:00.000|         3221.58|MONTH   |YEAR-QUARTER-MONTH-DAY|
--2021-01-01 00:00:00.000|2021-06-01 00:00:00.000|2021-06-20 00:00:00.000|2021-04-01 00:00:00.000|         3246.66|MONTH   |YEAR-QUARTER-MONTH-DAY|
--2021-01-01 00:00:00.000|2021-11-01 00:00:00.000|2021-11-25 00:00:00.000|2021-10-01 00:00:00.000|         2814.64|MONTH   |YEAR-QUARTER-MONTH-DAY|
--2021-01-01 00:00:00.000|2021-06-01 00:00:00.000|2021-06-30 00:00:00.000|2021-04-01 00:00:00.000|         3313.79|MONTH   |YEAR-QUARTER-MONTH-DAY|
--2021-01-01 00:00:00.000|2021-12-01 00:00:00.000|2021-12-28 00:00:00.000|2021-10-01 00:00:00.000|          2402.1|MONTH   |YEAR-QUARTER-MONTH-DAY|
--2021-01-01 00:00:00.000|2021-02-01 00:00:00.000|2021-02-12 00:00:00.000|2021-01-01 00:00:00.000|         3428.65|MONTH   |YEAR-QUARTER-MONTH-DAY|
--2022-01-01 00:00:00.000|2022-06-01 00:00:00.000|2022-06-25 00:00:00.000|2022-04-01 00:00:00.000|         4380.28|MONTH   |YEAR-QUARTER-MONTH-DAY|
--2021-01-01 00:00:00.000|2021-10-01 00:00:00.000|2021-10-07 00:00:00.000|2021-10-01 00:00:00.000|         2420.52|MONTH   |YEAR-QUARTER-MONTH-DAY|
--2021-01-01 00:00:00.000|2021-10-01 00:00:00.000|2021-10-30 00:00:00.000|2021-10-01 00:00:00.000|         2590.46|MONTH   |YEAR-QUARTER-MONTH-DAY|
--2021-01-01 00:00:00.000|2021-05-01 00:00:00.000|2021-05-02 00:00:00.000|2021-04-01 00:00:00.000|         3358.54|MONTH   |YEAR-QUARTER-MONTH-DAY|
--2021-01-01 00:00:00.000|2021-05-01 00:00:00.000|2021-05-17 00:00:00.000|2021-04-01 00:00:00.000|         3051.83|MONTH   |YEAR-QUARTER-MONTH-DAY|
--2022-01-01 00:00:00.000|2022-04-01 00:00:00.000|2022-04-24 00:00:00.000|2022-04-01 00:00:00.000|         4260.19|MONTH   |YEAR-QUARTER-MONTH-DAY|
--2021-01-01 00:00:00.000|2021-05-01 00:00:00.000|2021-05-07 00:00:00.000|2021-04-01 00:00:00.000|         2956.18|MONTH   |YEAR-QUARTER-MONTH-DAY|
--2021-01-01 00:00:00.000|2021-05-01 00:00:00.000|2021-05-25 00:00:00.000|2021-04-01 00:00:00.000|         3089.58|MONTH   |YEAR-QUARTER-MONTH-DAY|
--2022-01-01 00:00:00.000|2022-05-01 00:00:00.000|2022-05-14 00:00:00.000|2022-04-01 00:00:00.000|         4193.89|MONTH   |YEAR-QUARTER-MONTH-DAY|
--2022-01-01 00:00:00.000|2022-05-01 00:00:00.000|2022-05-10 00:00:00.000|2022-04-01 00:00:00.000|         4212.78|MONTH   |YEAR-QUARTER-MONTH-DAY|
--2022-01-01 00:00:00.000|2022-06-01 00:00:00.000|2022-06-23 00:00:00.000|2022-04-01 00:00:00.000|         4504.08|MONTH   |YEAR-QUARTER-MONTH-DAY|
--2021-01-01 00:00:00.000|2021-11-01 00:00:00.000|2021-11-29 00:00:00.000|2021-10-01 00:00:00.000|         2109.22|MONTH   |YEAR-QUARTER-MONTH-DAY|
--2022-01-01 00:00:00.000|2022-01-01 00:00:00.000|2022-01-29 00:00:00.000|2022-01-01 00:00:00.000|         2324.68|MONTH   |YEAR-QUARTER-MONTH-DAY|
--2022-01-01 00:00:00.000|2022-06-01 00:00:00.000|2022-06-20 00:00:00.000|2022-04-01 00:00:00.000|         4606.13|MONTH   |YEAR-QUARTER-MONTH-DAY|
--2022-01-01 00:00:00.000|2022-07-01 00:00:00.000|2022-07-20 00:00:00.000|2022-07-01 00:00:00.000|         4368.02|MONTH   |YEAR-QUARTER-MONTH-DAY|
--2021-01-01 00:00:00.000|2021-10-01 00:00:00.000|2021-10-24 00:00:00.000|2021-10-01 00:00:00.000|          2401.2|MONTH   |YEAR-QUARTER-MONTH-DAY|
--2021-01-01 00:00:00.000|2021-12-01 00:00:00.000|2021-12-30 00:00:00.000|2021-10-01 00:00:00.000|            2561|MONTH   |YEAR-QUARTER-MONTH-DAY|
--2022-01-01 00:00:00.000|2022-03-01 00:00:00.000|2022-03-25 00:00:00.000|2022-01-01 00:00:00.000|         4086.27|MONTH   |YEAR-QUARTER-MONTH-DAY|
--2021-01-01 00:00:00.000|2021-10-01 00:00:00.000|2021-10-03 00:00:00.000|2021-10-01 00:00:00.000|         2443.42|MONTH   |YEAR-QUARTER-MONTH-DAY|
--2021-01-01 00:00:00.000|2021-12-01 00:00:00.000|2021-12-19 00:00:00.000|2021-10-01 00:00:00.000|         2533.17|MONTH   |YEAR-QUARTER-MONTH-DAY|
--2022-01-01 00:00:00.000|2022-02-01 00:00:00.000|2022-02-11 00:00:00.000|2022-01-01 00:00:00.000|          2449.8|MONTH   |YEAR-QUARTER-MONTH-DAY|
--2021-01-01 00:00:00.000|2021-04-01 00:00:00.000|2021-04-12 00:00:00.000|2021-04-01 00:00:00.000|         3108.25|MONTH   |YEAR-QUARTER-MONTH-DAY|
--2021-01-01 00:00:00.000|2021-12-01 00:00:00.000|2021-12-23 00:00:00.000|2021-10-01 00:00:00.000|         2441.42|MONTH   |YEAR-QUARTER-MONTH-DAY|
--2021-01-01 00:00:00.000|2021-09-01 00:00:00.000|2021-09-12 00:00:00.000|2021-07-01 00:00:00.000|        13972.96|MONTH   |YEAR-QUARTER-MONTH-DAY|
--2021-01-01 00:00:00.000|2021-07-01 00:00:00.000|2021-07-24 00:00:00.000|2021-07-01 00:00:00.000|         3094.42|MONTH   |YEAR-QUARTER-MONTH-DAY|
--2021-01-01 00:00:00.000|2021-10-01 00:00:00.000|2021-10-17 00:00:00.000|2021-10-01 00:00:00.000|         2284.55|MONTH   |YEAR-QUARTER-MONTH-DAY|
--2021-01-01 00:00:00.000|2021-10-01 00:00:00.000|2021-10-26 00:00:00.000|2021-10-01 00:00:00.000|         2149.39|MONTH   |YEAR-QUARTER-MONTH-DAY|
--2021-01-01 00:00:00.000|2021-08-01 00:00:00.000|2021-08-17 00:00:00.000|2021-07-01 00:00:00.000|        15480.55|MONTH   |YEAR-QUARTER-MONTH-DAY|
--2021-01-01 00:00:00.000|2021-08-01 00:00:00.000|2021-08-22 00:00:00.000|2021-07-01 00:00:00.000|        14471.34|MONTH   |YEAR-QUARTER-MONTH-DAY|
--2021-01-01 00:00:00.000|2021-09-01 00:00:00.000|2021-09-08 00:00:00.000|2021-07-01 00:00:00.000|        14524.04|MONTH   |YEAR-QUARTER-MONTH-DAY|
--2021-01-01 00:00:00.000|2021-03-01 00:00:00.000|2021-03-28 00:00:00.000|2021-01-01 00:00:00.000|         3378.64|MONTH   |YEAR-QUARTER-MONTH-DAY|
--2021-01-01 00:00:00.000|2021-09-01 00:00:00.000|2021-09-14 00:00:00.000|2021-07-01 00:00:00.000|        14204.94|MONTH   |YEAR-QUARTER-MONTH-DAY|
--2021-01-01 00:00:00.000|2021-04-01 00:00:00.000|2021-04-27 00:00:00.000|2021-04-01 00:00:00.000|         3140.99|MONTH   |YEAR-QUARTER-MONTH-DAY|
--2022-01-01 00:00:00.000|2022-05-01 00:00:00.000|2022-05-23 00:00:00.000|2022-04-01 00:00:00.000|         4159.79|MONTH   |YEAR-QUARTER-MONTH-DAY|
--2021-01-01 00:00:00.000|2021-05-01 00:00:00.000|2021-05-30 00:00:00.000|2021-04-01 00:00:00.000|         3209.58|MONTH   |YEAR-QUARTER-MONTH-DAY|
--2022-01-01 00:00:00.000|2022-02-01 00:00:00.000|2022-02-01 00:00:00.000|2022-01-01 00:00:00.000|         2683.22|MONTH   |YEAR-QUARTER-MONTH-DAY|
--2021-01-01 00:00:00.000|2021-08-01 00:00:00.000|2021-08-15 00:00:00.000|2021-07-01 00:00:00.000|        15208.37|MONTH   |YEAR-QUARTER-MONTH-DAY|
--2021-01-01 00:00:00.000|2021-07-01 00:00:00.000|2021-07-01 00:00:00.000|2021-07-01 00:00:00.000|         3246.12|MONTH   |YEAR-QUARTER-MONTH-DAY|
--2021-01-01 00:00:00.000|2021-08-01 00:00:00.000|2021-08-28 00:00:00.000|2021-07-01 00:00:00.000|        15243.21|MONTH   |YEAR-QUARTER-MONTH-DAY|
--2021-01-01 00:00:00.000|2021-07-01 00:00:00.000|2021-07-27 00:00:00.000|2021-07-01 00:00:00.000|         3109.57|MONTH   |YEAR-QUARTER-MONTH-DAY|
--2021-01-01 00:00:00.000|2021-11-01 00:00:00.000|2021-11-18 00:00:00.000|2021-10-01 00:00:00.000|         2517.04|MONTH   |YEAR-QUARTER-MONTH-DAY|
--2022-01-01 00:00:00.000|2022-04-01 00:00:00.000|2022-04-18 00:00:00.000|2022-04-01 00:00:00.000|         4157.32|MONTH   |YEAR-QUARTER-MONTH-DAY|
--2022-01-01 00:00:00.000|2022-06-01 00:00:00.000|2022-06-02 00:00:00.000|2022-04-01 00:00:00.000|         4102.91|MONTH   |YEAR-QUARTER-MONTH-DAY|
--2022-01-01 00:00:00.000|2022-06-01 00:00:00.000|2022-06-13 00:00:00.000|2022-04-01 00:00:00.000|         4339.77|MONTH   |YEAR-QUARTER-MONTH-DAY|
--2021-01-01 00:00:00.000|2021-05-01 00:00:00.000|2021-05-14 00:00:00.000|2021-04-01 00:00:00.000|         3286.33|MONTH   |YEAR-QUARTER-MONTH-DAY|
--2022-01-01 00:00:00.000|2022-03-01 00:00:00.000|2022-03-02 00:00:00.000|2022-01-01 00:00:00.000|         4381.64|MONTH   |YEAR-QUARTER-MONTH-DAY|
--2021-01-01 00:00:00.000|2021-11-01 00:00:00.000|2021-11-06 00:00:00.000|2021-10-01 00:00:00.000|          2392.2|MONTH   |YEAR-QUARTER-MONTH-DAY|
--2021-01-01 00:00:00.000|2021-07-01 00:00:00.000|2021-07-13 00:00:00.000|2021-07-01 00:00:00.000|         3294.27|MONTH   |YEAR-QUARTER-MONTH-DAY|
--2022-01-01 00:00:00.000|2022-01-01 00:00:00.000|2022-01-01 00:00:00.000|2022-01-01 00:00:00.000|         2465.46|MONTH   |YEAR-QUARTER-MONTH-DAY|
--2022-01-01 00:00:00.000|2022-06-01 00:00:00.000|2022-06-06 00:00:00.000|2022-04-01 00:00:00.000|         4997.43|MONTH   |YEAR-QUARTER-MONTH-DAY|
--2021-01-01 00:00:00.000|2021-04-01 00:00:00.000|2021-04-29 00:00:00.000|2021-04-01 00:00:00.000|         3318.56|MONTH   |YEAR-QUARTER-MONTH-DAY|
--2022-01-01 00:00:00.000|2022-03-01 00:00:00.000|2022-03-05 00:00:00.000|2022-01-01 00:00:00.000|         4129.98|MONTH   |YEAR-QUARTER-MONTH-DAY|
--2021-01-01 00:00:00.000|2021-05-01 00:00:00.000|2021-05-16 00:00:00.000|2021-04-01 00:00:00.000|         3156.88|MONTH   |YEAR-QUARTER-MONTH-DAY|
--2022-01-01 00:00:00.000|2022-03-01 00:00:00.000|2022-03-18 00:00:00.000|2022-01-01 00:00:00.000|         4388.79|MONTH   |YEAR-QUARTER-MONTH-DAY|
--2021-01-01 00:00:00.000|2021-11-01 00:00:00.000|2021-11-16 00:00:00.000|2021-10-01 00:00:00.000|         2680.52|MONTH   |YEAR-QUARTER-MONTH-DAY|
--2021-01-01 00:00:00.000|2021-06-01 00:00:00.000|2021-06-27 00:00:00.000|2021-04-01 00:00:00.000|         3098.12|MONTH   |YEAR-QUARTER-MONTH-DAY|
--2022-01-01 00:00:00.000|2022-04-01 00:00:00.000|2022-04-21 00:00:00.000|2022-04-01 00:00:00.000|         4520.18|MONTH   |YEAR-QUARTER-MONTH-DAY|
--2022-01-01 00:00:00.000|2022-04-01 00:00:00.000|2022-04-17 00:00:00.000|2022-04-01 00:00:00.000|         4233.54|MONTH   |YEAR-QUARTER-MONTH-DAY|
--2022-01-01 00:00:00.000|2022-04-01 00:00:00.000|2022-04-26 00:00:00.000|2022-04-01 00:00:00.000|         4533.37|MONTH   |YEAR-QUARTER-MONTH-DAY|
--2021-01-01 00:00:00.000|2021-12-01 00:00:00.000|2021-12-22 00:00:00.000|2021-10-01 00:00:00.000|          2524.2|MONTH   |YEAR-QUARTER-MONTH-DAY|
--2021-01-01 00:00:00.000|2021-02-01 00:00:00.000|2021-02-10 00:00:00.000|2021-01-01 00:00:00.000|         3272.76|MONTH   |YEAR-QUARTER-MONTH-DAY|
--2022-01-01 00:00:00.000|2022-01-01 00:00:00.000|2022-01-17 00:00:00.000|2022-01-01 00:00:00.000|         2113.22|MONTH   |YEAR-QUARTER-MONTH-DAY|
--2021-01-01 00:00:00.000|2021-04-01 00:00:00.000|2021-04-18 00:00:00.000|2021-04-01 00:00:00.000|         3210.19|MONTH   |YEAR-QUARTER-MONTH-DAY|
--2021-01-01 00:00:00.000|2021-05-01 00:00:00.000|2021-05-01 00:00:00.000|2021-04-01 00:00:00.000|         3192.69|MONTH   |YEAR-QUARTER-MONTH-DAY|
--2022-01-01 00:00:00.000|2022-01-01 00:00:00.000|2022-01-21 00:00:00.000|2022-01-01 00:00:00.000|         2314.89|MONTH   |YEAR-QUARTER-MONTH-DAY|
--2022-01-01 00:00:00.000|2022-07-01 00:00:00.000|2022-07-06 00:00:00.000|2022-07-01 00:00:00.000|         4656.06|MONTH   |YEAR-QUARTER-MONTH-DAY|
--2021-01-01 00:00:00.000|2021-06-01 00:00:00.000|2021-06-08 00:00:00.000|2021-04-01 00:00:00.000|          3095.5|MONTH   |YEAR-QUARTER-MONTH-DAY|
--2021-01-01 00:00:00.000|2021-06-01 00:00:00.000|2021-06-12 00:00:00.000|2021-04-01 00:00:00.000|         3338.25|MONTH   |YEAR-QUARTER-MONTH-DAY|
--2022-01-01 00:00:00.000|2022-03-01 00:00:00.000|2022-03-26 00:00:00.000|2022-01-01 00:00:00.000|         4352.84|MONTH   |YEAR-QUARTER-MONTH-DAY|
--2021-01-01 00:00:00.000|2021-11-01 00:00:00.000|2021-11-24 00:00:00.000|2021-10-01 00:00:00.000|         2617.67|MONTH   |YEAR-QUARTER-MONTH-DAY|
--2022-01-01 00:00:00.000|2022-04-01 00:00:00.000|2022-04-27 00:00:00.000|2022-04-01 00:00:00.000|         4289.83|MONTH   |YEAR-QUARTER-MONTH-DAY|
--2021-01-01 00:00:00.000|2021-06-01 00:00:00.000|2021-06-13 00:00:00.000|2021-04-01 00:00:00.000|         2912.25|MONTH   |YEAR-QUARTER-MONTH-DAY|
--2021-01-01 00:00:00.000|2021-10-01 00:00:00.000|2021-10-05 00:00:00.000|2021-10-01 00:00:00.000|         2409.76|MONTH   |YEAR-QUARTER-MONTH-DAY|
--2022-01-01 00:00:00.000|2022-03-01 00:00:00.000|2022-03-10 00:00:00.000|2022-01-01 00:00:00.000|         4430.43|MONTH   |YEAR-QUARTER-MONTH-DAY|
--2022-01-01 00:00:00.000|2022-01-01 00:00:00.000|2022-01-06 00:00:00.000|2022-01-01 00:00:00.000|         2664.33|MONTH   |YEAR-QUARTER-MONTH-DAY|
--2022-01-01 00:00:00.000|2022-05-01 00:00:00.000|2022-05-18 00:00:00.000|2022-04-01 00:00:00.000|         4218.97|MONTH   |YEAR-QUARTER-MONTH-DAY|
--2022-01-01 00:00:00.000|2022-01-01 00:00:00.000|2022-01-05 00:00:00.000|2022-01-01 00:00:00.000|         2266.79|MONTH   |YEAR-QUARTER-MONTH-DAY|
--2022-01-01 00:00:00.000|2022-06-01 00:00:00.000|2022-06-16 00:00:00.000|2022-04-01 00:00:00.000|         4188.81|MONTH   |YEAR-QUARTER-MONTH-DAY|
--2021-01-01 00:00:00.000|2021-02-01 00:00:00.000|2021-02-28 00:00:00.000|2021-01-01 00:00:00.000|         2976.02|MONTH   |YEAR-QUARTER-MONTH-DAY|
--2022-01-01 00:00:00.000|2022-02-01 00:00:00.000|2022-02-25 00:00:00.000|2022-01-01 00:00:00.000|         2270.94|MONTH   |YEAR-QUARTER-MONTH-DAY|
--2022-01-01 00:00:00.000|2022-03-01 00:00:00.000|2022-03-23 00:00:00.000|2022-01-01 00:00:00.000|         4170.41|MONTH   |YEAR-QUARTER-MONTH-DAY|
--2022-01-01 00:00:00.000|2022-06-01 00:00:00.000|2022-06-07 00:00:00.000|2022-04-01 00:00:00.000|         4190.78|MONTH   |YEAR-QUARTER-MONTH-DAY|
--2022-01-01 00:00:00.000|2022-06-01 00:00:00.000|2022-06-24 00:00:00.000|2022-04-01 00:00:00.000|         4397.08|MONTH   |YEAR-QUARTER-MONTH-DAY|
--2022-01-01 00:00:00.000|2022-06-01 00:00:00.000|2022-06-01 00:00:00.000|2022-04-01 00:00:00.000|         4539.54|MONTH   |YEAR-QUARTER-MONTH-DAY|
--2021-01-01 00:00:00.000|2021-05-01 00:00:00.000|2021-05-13 00:00:00.000|2021-04-01 00:00:00.000|         3172.29|MONTH   |YEAR-QUARTER-MONTH-DAY|
--2021-01-01 00:00:00.000|2021-11-01 00:00:00.000|2021-11-13 00:00:00.000|2021-10-01 00:00:00.000|         2600.71|MONTH   |YEAR-QUARTER-MONTH-DAY|
--2021-01-01 00:00:00.000|2021-11-01 00:00:00.000|2021-11-17 00:00:00.000|2021-10-01 00:00:00.000|         2650.25|MONTH   |YEAR-QUARTER-MONTH-DAY|
--2021-01-01 00:00:00.000|2021-02-01 00:00:00.000|2021-02-18 00:00:00.000|2021-01-01 00:00:00.000|         3063.91|MONTH   |YEAR-QUARTER-MONTH-DAY|
--2021-01-01 00:00:00.000|2021-08-01 00:00:00.000|2021-08-19 00:00:00.000|2021-07-01 00:00:00.000|        15091.48|MONTH   |YEAR-QUARTER-MONTH-DAY|
--2021-01-01 00:00:00.000|2021-10-01 00:00:00.000|2021-10-27 00:00:00.000|2021-10-01 00:00:00.000|         2591.85|MONTH   |YEAR-QUARTER-MONTH-DAY|
--2021-01-01 00:00:00.000|2021-08-01 00:00:00.000|2021-08-24 00:00:00.000|2021-07-01 00:00:00.000|        14415.63|MONTH   |YEAR-QUARTER-MONTH-DAY|
--2021-01-01 00:00:00.000|2021-09-01 00:00:00.000|2021-09-06 00:00:00.000|2021-07-01 00:00:00.000|         14662.2|MONTH   |YEAR-QUARTER-MONTH-DAY|
--2021-01-01 00:00:00.000|2021-09-01 00:00:00.000|2021-09-09 00:00:00.000|2021-07-01 00:00:00.000|        15469.09|MONTH   |YEAR-QUARTER-MONTH-DAY|
--2021-01-01 00:00:00.000|2021-11-01 00:00:00.000|2021-11-23 00:00:00.000|2021-10-01 00:00:00.000|         2404.87|MONTH   |YEAR-QUARTER-MONTH-DAY|
--2021-01-01 00:00:00.000|2021-09-01 00:00:00.000|2021-09-17 00:00:00.000|2021-07-01 00:00:00.000|        14852.91|MONTH   |YEAR-QUARTER-MONTH-DAY|
--2021-01-01 00:00:00.000|2021-04-01 00:00:00.000|2021-04-03 00:00:00.000|2021-04-01 00:00:00.000|         3358.04|MONTH   |YEAR-QUARTER-MONTH-DAY|
--2021-01-01 00:00:00.000|2021-12-01 00:00:00.000|2021-12-03 00:00:00.000|2021-10-01 00:00:00.000|         2352.74|MONTH   |YEAR-QUARTER-MONTH-DAY|
--2021-01-01 00:00:00.000|2021-04-01 00:00:00.000|2021-04-20 00:00:00.000|2021-04-01 00:00:00.000|         3140.65|MONTH   |YEAR-QUARTER-MONTH-DAY|
--2022-01-01 00:00:00.000|2022-05-01 00:00:00.000|2022-05-09 00:00:00.000|2022-04-01 00:00:00.000|         4164.56|MONTH   |YEAR-QUARTER-MONTH-DAY|
--2021-01-01 00:00:00.000|2021-12-01 00:00:00.000|2021-12-15 00:00:00.000|2021-10-01 00:00:00.000|         2491.89|MONTH   |YEAR-QUARTER-MONTH-DAY|
--2021-01-01 00:00:00.000|2021-05-01 00:00:00.000|2021-05-09 00:00:00.000|2021-04-01 00:00:00.000|         2900.95|MONTH   |YEAR-QUARTER-MONTH-DAY|
--2021-01-01 00:00:00.000|2021-06-01 00:00:00.000|2021-06-02 00:00:00.000|2021-04-01 00:00:00.000|         3186.53|MONTH   |YEAR-QUARTER-MONTH-DAY|
--2021-01-01 00:00:00.000|2021-06-01 00:00:00.000|2021-06-09 00:00:00.000|2021-04-01 00:00:00.000|         3002.69|MONTH   |YEAR-QUARTER-MONTH-DAY|
--2021-01-01 00:00:00.000|2021-06-01 00:00:00.000|2021-06-17 00:00:00.000|2021-04-01 00:00:00.000|         3038.23|MONTH   |YEAR-QUARTER-MONTH-DAY|
--2022-01-01 00:00:00.000|2022-02-01 00:00:00.000|2022-02-07 00:00:00.000|2022-01-01 00:00:00.000|         2375.49|MONTH   |YEAR-QUARTER-MONTH-DAY|
--2022-01-01 00:00:00.000|2022-02-01 00:00:00.000|2022-02-09 00:00:00.000|2022-01-01 00:00:00.000|         2399.72|MONTH   |YEAR-QUARTER-MONTH-DAY|
--2022-01-01 00:00:00.000|2022-02-01 00:00:00.000|2022-02-24 00:00:00.000|2022-01-01 00:00:00.000|         2691.55|MONTH   |YEAR-QUARTER-MONTH-DAY|
--2022-01-01 00:00:00.000|2022-07-01 00:00:00.000|2022-07-14 00:00:00.000|2022-07-01 00:00:00.000|         4446.96|MONTH   |YEAR-QUARTER-MONTH-DAY|
--2021-01-01 00:00:00.000|2021-10-01 00:00:00.000|2021-10-15 00:00:00.000|2021-10-01 00:00:00.000|         2472.68|MONTH   |YEAR-QUARTER-MONTH-DAY|
--2022-01-01 00:00:00.000|2022-03-01 00:00:00.000|2022-03-11 00:00:00.000|2022-01-01 00:00:00.000|         4344.94|MONTH   |YEAR-QUARTER-MONTH-DAY|
--2022-01-01 00:00:00.000|2022-03-01 00:00:00.000|2022-03-12 00:00:00.000|2022-01-01 00:00:00.000|         4444.57|MONTH   |YEAR-QUARTER-MONTH-DAY|
--2021-01-01 00:00:00.000|2021-09-01 00:00:00.000|2021-09-05 00:00:00.000|2021-07-01 00:00:00.000|        15039.55|MONTH   |YEAR-QUARTER-MONTH-DAY|
--2022-01-01 00:00:00.000|2022-03-01 00:00:00.000|2022-03-15 00:00:00.000|2022-01-01 00:00:00.000|         4220.69|MONTH   |YEAR-QUARTER-MONTH-DAY|
--2022-01-01 00:00:00.000|2022-03-01 00:00:00.000|2022-03-27 00:00:00.000|2022-01-01 00:00:00.000|         4310.26|MONTH   |YEAR-QUARTER-MONTH-DAY|
--2022-01-01 00:00:00.000|2022-04-01 00:00:00.000|2022-04-03 00:00:00.000|2022-04-01 00:00:00.000|         4366.82|MONTH   |YEAR-QUARTER-MONTH-DAY|
--2021-01-01 00:00:00.000|2021-08-01 00:00:00.000|2021-08-05 00:00:00.000|2021-07-01 00:00:00.000|        14530.77|MONTH   |YEAR-QUARTER-MONTH-DAY|
--2021-01-01 00:00:00.000|2021-02-01 00:00:00.000|2021-02-24 00:00:00.000|2021-01-01 00:00:00.000|         3434.18|MONTH   |YEAR-QUARTER-MONTH-DAY|
--2021-01-01 00:00:00.000|2021-03-01 00:00:00.000|2021-03-06 00:00:00.000|2021-01-01 00:00:00.000|          3429.8|MONTH   |YEAR-QUARTER-MONTH-DAY|
--2022-01-01 00:00:00.000|2022-05-01 00:00:00.000|2022-05-08 00:00:00.000|2022-04-01 00:00:00.000|         4517.38|MONTH   |YEAR-QUARTER-MONTH-DAY|
--2022-01-01 00:00:00.000|2022-05-01 00:00:00.000|2022-05-22 00:00:00.000|2022-04-01 00:00:00.000|         4510.01|MONTH   |YEAR-QUARTER-MONTH-DAY|
--2022-01-01 00:00:00.000|2022-01-01 00:00:00.000|2022-01-08 00:00:00.000|2022-01-01 00:00:00.000|         2688.93|MONTH   |YEAR-QUARTER-MONTH-DAY|
--2021-01-01 00:00:00.000|2021-04-01 00:00:00.000|2021-04-17 00:00:00.000|2021-04-01 00:00:00.000|         3280.64|MONTH   |YEAR-QUARTER-MONTH-DAY|
--2021-01-01 00:00:00.000|2021-04-01 00:00:00.000|2021-04-30 00:00:00.000|2021-04-01 00:00:00.000|         3080.41|MONTH   |YEAR-QUARTER-MONTH-DAY|
--2021-01-01 00:00:00.000|2021-04-01 00:00:00.000|2021-04-26 00:00:00.000|2021-04-01 00:00:00.000|         3376.11|MONTH   |YEAR-QUARTER-MONTH-DAY|
--2022-01-01 00:00:00.000|2022-02-01 00:00:00.000|2022-02-27 00:00:00.000|2022-01-01 00:00:00.000|         2467.97|MONTH   |YEAR-QUARTER-MONTH-DAY|
--2021-01-01 00:00:00.000|2021-06-01 00:00:00.000|2021-06-01 00:00:00.000|2021-04-01 00:00:00.000|         3094.92|MONTH   |YEAR-QUARTER-MONTH-DAY|
--2022-01-01 00:00:00.000|2022-07-01 00:00:00.000|2022-07-23 00:00:00.000|2022-07-01 00:00:00.000|         4518.36|MONTH   |YEAR-QUARTER-MONTH-DAY|
--2021-01-01 00:00:00.000|2021-06-01 00:00:00.000|2021-06-15 00:00:00.000|2021-04-01 00:00:00.000|         3171.89|MONTH   |YEAR-QUARTER-MONTH-DAY|
--2021-01-01 00:00:00.000|2021-07-01 00:00:00.000|2021-07-19 00:00:00.000|2021-07-01 00:00:00.000|         2956.62|MONTH   |YEAR-QUARTER-MONTH-DAY|
--2021-01-01 00:00:00.000|2021-02-01 00:00:00.000|2021-02-02 00:00:00.000|2021-01-01 00:00:00.000|         3394.91|MONTH   |YEAR-QUARTER-MONTH-DAY|
--2021-01-01 00:00:00.000|2021-12-01 00:00:00.000|2021-12-10 00:00:00.000|2021-10-01 00:00:00.000|         2240.64|MONTH   |YEAR-QUARTER-MONTH-DAY|
--2021-01-01 00:00:00.000|2021-03-01 00:00:00.000|2021-03-22 00:00:00.000|2021-01-01 00:00:00.000|         3318.13|MONTH   |YEAR-QUARTER-MONTH-DAY|
--2022-01-01 00:00:00.000|2022-01-01 00:00:00.000|2022-01-25 00:00:00.000|2022-01-01 00:00:00.000|         2461.74|MONTH   |YEAR-QUARTER-MONTH-DAY|
--2022-01-01 00:00:00.000|2022-01-01 00:00:00.000|2022-01-28 00:00:00.000|2022-01-01 00:00:00.000|          2340.2|MONTH   |YEAR-QUARTER-MONTH-DAY|
--2022-01-01 00:00:00.000|2022-07-01 00:00:00.000|2022-07-07 00:00:00.000|2022-07-01 00:00:00.000|         4596.24|MONTH   |YEAR-QUARTER-MONTH-DAY|
--2022-01-01 00:00:00.000|2022-03-01 00:00:00.000|2022-03-07 00:00:00.000|2022-01-01 00:00:00.000|         4338.42|MONTH   |YEAR-QUARTER-MONTH-DAY|
--2021-01-01 00:00:00.000|2021-06-01 00:00:00.000|2021-06-10 00:00:00.000|2021-04-01 00:00:00.000|         3474.21|MONTH   |YEAR-QUARTER-MONTH-DAY|
--2021-01-01 00:00:00.000|2021-02-01 00:00:00.000|2021-02-04 00:00:00.000|2021-01-01 00:00:00.000|         3286.37|MONTH   |YEAR-QUARTER-MONTH-DAY|
--2021-01-01 00:00:00.000|2021-02-01 00:00:00.000|2021-02-15 00:00:00.000|2021-01-01 00:00:00.000|         3157.91|MONTH   |YEAR-QUARTER-MONTH-DAY|
--2022-01-01 00:00:00.000|2022-06-01 00:00:00.000|2022-06-29 00:00:00.000|2022-04-01 00:00:00.000|         4800.37|MONTH   |YEAR-QUARTER-MONTH-DAY|
--2021-01-01 00:00:00.000|2021-08-01 00:00:00.000|2021-08-12 00:00:00.000|2021-07-01 00:00:00.000|        14575.72|MONTH   |YEAR-QUARTER-MONTH-DAY|
--2021-01-01 00:00:00.000|2021-11-01 00:00:00.000|2021-11-27 00:00:00.000|2021-10-01 00:00:00.000|         2638.32|MONTH   |YEAR-QUARTER-MONTH-DAY|
--2022-01-01 00:00:00.000|2022-06-01 00:00:00.000|2022-06-05 00:00:00.000|2022-04-01 00:00:00.000|         4198.44|MONTH   |YEAR-QUARTER-MONTH-DAY|
--2021-01-01 00:00:00.000|2021-03-01 00:00:00.000|2021-03-07 00:00:00.000|2021-01-01 00:00:00.000|         3140.74|MONTH   |YEAR-QUARTER-MONTH-DAY|
--2022-01-01 00:00:00.000|2022-04-01 00:00:00.000|2022-04-08 00:00:00.000|2022-04-01 00:00:00.000|         4066.39|MONTH   |YEAR-QUARTER-MONTH-DAY|
--2022-01-01 00:00:00.000|2022-05-01 00:00:00.000|2022-05-03 00:00:00.000|2022-04-01 00:00:00.000|         4253.76|MONTH   |YEAR-QUARTER-MONTH-DAY|
--2022-01-01 00:00:00.000|2022-05-01 00:00:00.000|2022-05-12 00:00:00.000|2022-04-01 00:00:00.000|         4241.07|MONTH   |YEAR-QUARTER-MONTH-DAY|
--2022-01-01 00:00:00.000|2022-01-01 00:00:00.000|2022-01-30 00:00:00.000|2022-01-01 00:00:00.000|         2313.25|MONTH   |YEAR-QUARTER-MONTH-DAY|
--2022-01-01 00:00:00.000|2022-07-01 00:00:00.000|2022-07-12 00:00:00.000|2022-07-01 00:00:00.000|            4234|MONTH   |YEAR-QUARTER-MONTH-DAY|
--2021-01-01 00:00:00.000|2021-03-01 00:00:00.000|2021-03-24 00:00:00.000|2021-01-01 00:00:00.000|         3233.81|MONTH   |YEAR-QUARTER-MONTH-DAY|
--2021-01-01 00:00:00.000|2021-05-01 00:00:00.000|2021-05-03 00:00:00.000|2021-04-01 00:00:00.000|          3326.9|MONTH   |YEAR-QUARTER-MONTH-DAY|
--2022-01-01 00:00:00.000|2022-01-01 00:00:00.000|2022-01-18 00:00:00.000|2022-01-01 00:00:00.000|         2679.35|MONTH   |YEAR-QUARTER-MONTH-DAY|
--2021-01-01 00:00:00.000|2021-05-01 00:00:00.000|2021-05-04 00:00:00.000|2021-04-01 00:00:00.000|         3203.33|MONTH   |YEAR-QUARTER-MONTH-DAY|
--2021-01-01 00:00:00.000|2021-07-01 00:00:00.000|2021-07-21 00:00:00.000|2021-07-01 00:00:00.000|         3126.25|MONTH   |YEAR-QUARTER-MONTH-DAY|
 
 
```