# Task 2

```sql
set timing on
select * from tmp;	
Elapsed: 00:00:00.428

----------------------------------------------------------------------------
--| Id  | Operation         | Name | Rows  | Bytes | Cost (%CPU)| Time     |
----------------------------------------------------------------------------
--|   0 | SELECT STATEMENT  |      |   111K|   267M|  2381   (1)| 00:00:01 |
--|   1 |  TABLE ACCESS FULL| TMP  |   111K|   267M|  2381   (1)| 00:00:01 |
----------------------------------------------------------------------------

set timing on
select /*+ PARALLEL(10) ENABLE_PARALLEL_DML */ * from tmp;	
Elapsed: 00:00:00.396

----------------------------------------------------------------------------------------------------------------
--| Id  | Operation            | Name     | Rows  | Bytes | Cost (%CPU)| Time     |    TQ  |IN-OUT| PQ Distrib |
----------------------------------------------------------------------------------------------------------------
--|   0 | SELECT STATEMENT     |          |   160K|    51M|   529   (0)| 00:00:01 |        |      |            |
--|   1 |  PX COORDINATOR      |          |       |       |            |          |        |      |            |
--|   2 |   PX SEND QC (RANDOM)| :TQ10000 |   160K|    51M|   529   (0)| 00:00:01 |  Q1,00 | P->S | QC (RAND)  |
--|   3 |    PX BLOCK ITERATOR |          |   160K|    51M|   529   (0)| 00:00:01 |  Q1,00 | PCWC |            |
--|   4 |     TABLE ACCESS FULL| TMP      |   160K|    51M|   529   (0)| 00:00:01 |  Q1,00 | PCWP |            |
----------------------------------------------------------------------------------------------------------------
             | Elapsed
---------------------------
Not parallel | 00:00:00.428
With parallel| 00:00:00.396
```


