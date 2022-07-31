### Task9

```sql

SELECT * FROM DBA_TAB_PRIVS where table_name in ('T_AUCTIONS_F');

--GRANTEE     |OWNER        |TABLE_NAME  |GRANTOR      |PRIVILEGE|GRANTABLE|HIERARCHY|COMMON|TYPE |INHERITED|
--------------+-------------+------------+-------------+---------+---------+---------+------+-----+---------+
--U_DW_PERSONS|U_DW_AUCTIONS|T_AUCTIONS_F|U_DW_AUCTIONS|READ     |NO       |NO       |NO    |TABLE|NO       |
```