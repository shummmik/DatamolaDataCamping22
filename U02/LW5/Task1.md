# Task 1

```sql

create or replace PACKAGE                     U_DW_PRODUCTS.pkg_ELT_DIM_PRODUCTS
AS  
   PROCEDURE LOAD_DIM_PRODUCTS;

END pkg_ELT_DIM_PRODUCTS;


create or replace PACKAGE BODY                     U_DW_PRODUCTS.pkg_ELT_DIM_PRODUCTS
AS

   PROCEDURE LOAD_DIM_PRODUCTS
   IS
  
  SQL_QUERY VARCHAR2(2000) := 'SELECT 
        T.ID_PROD,
       T.NAME,
       T.START_OF_COSTS,
       T.FINISH_OF_COST ,
       C.NAME CATEGORY,
       T.IMAGE,
       T.PLATFORM  ,
       T.CATEGORY_PLATFORM ,
       T.IMAGE_PLATFORM 
    FROM 
        (SELECT P.*, 
                PPL.PLATFORM,
                PPL.CATEGORY_PLATFORM,
                PPL.IMAGE_PLATFORM,
                PPL.DESCRIPTION_PLATFORM
            FROM
            U_DW_PRODUCTS.T_PRODUCTS P
            INNER JOIN
            (   SELECT PL.ID_PLATFORM,
                        PL.NAME PLATFORM,
                        CP.NAME CATEGORY_PLATFORM,
                        PL.IMAGE IMAGE_PLATFORM,
                        PL.DESCRIPTION DESCRIPTION_PLATFORM
                FROM 
                    U_DW_PRODUCTS.T_PLATFORM PL
                    INNER JOIN 
                    U_DW_PRODUCTS.T_CATEGORY_PLATFORM CP
                ON
                PL.ID_CATEGORY_PLATFORM=CP.ID_CATEGORY_PLATFORM
            ) PPL
            ON 
            P.ID_PLATFORM=PPL.ID_PLATFORM
            
        ) T
        INNER JOIN 
        U_DW_PRODUCTS.T_CATEGORY C
        ON 
        T.ID_CATEGORY=C.ID_CATEGORY';

    type PRODUCTS_rcur IS REF CURSOR;
    type_PRODUCTS PRODUCTS_rcur;

    TYPE row_type IS RECORD
	   (
        ID_PROD NUMBER ,
        NAME CHAR(200 BYTE),
        START_OF_COSTS FLOAT(126),
        FINISH_OF_COST FLOAT(126),
        CATEGORY CHAR(50 BYTE),
        IMAGE VARCHAR2(10 BYTE),
        PLATFORM VARCHAR2(200 BYTE),
        CATEGORY_PLATFORM VARCHAR2(100 BYTE),
        IMAGE_PLATFORM VARCHAR2(200 BYTE)
	   );

    R_TABLE row_type;
    curid NUMBER;
    exec_cur  NUMBER;
 begin

 EXECUTE IMMEDIATE 'TRUNCATE TABLE U_DW_PRODUCTS.DIM_PRODUCTS';
 curid := dbms_sql.open_cursor;
 
  DBMS_SQL.parse(curid, SQL_QUERY, DBMS_SQL.NATIVE);


  exec_cur := DBMS_SQL.EXECUTE(curid);

  type_PRODUCTS  := DBMS_SQL.to_refcursor(curid);

  LOOP

    FETCH type_PRODUCTS into R_TABLE;
    exit when type_PRODUCTS%notfound;
    
    Insert into  U_DW_PRODUCTS.DIM_PRODUCTS 
        values 
        (
        R_TABLE.ID_PROD,
           R_TABLE.NAME,
           R_TABLE.START_OF_COSTS,
           R_TABLE.FINISH_OF_COST ,
           R_TABLE.CATEGORY,
           R_TABLE.IMAGE ,
           R_TABLE.PLATFORM  ,
           R_TABLE.CATEGORY_PLATFORM ,
           R_TABLE.IMAGE_PLATFORM  );
           COMMIT;



  END LOOP;
  

 IF DBMS_SQL.IS_OPEN( curid ) THEN
    DBMS_SQL.CLOSE_CURSOR( curid);
  end if;
END LOAD_DIM_PRODUCTS;


END pkg_ELT_DIM_PRODUCTS;
 
 
 ---+++++
 
exec U_DW_PRODUCTS.pkg_ELT_DIM_PRODUCTS.LOAD_DIM_PRODUCTS;



















create or replace PACKAGE                     U_DW_PRODUCTS.pkg_ELT_DIM_PRODUCTS
AS  
   PROCEDURE LOAD_DIM_PRODUCTS;

END pkg_ELT_DIM_PRODUCTS;


create or replace PACKAGE BODY                     U_DW_PRODUCTS.pkg_ELT_DIM_PRODUCTS
AS

   PROCEDURE LOAD_DIM_PRODUCTS
   IS
  
  SQL_QUERY VARCHAR2(2000) := 'SELECT 
        T.ID_PROD,
       T.NAME,
       T.START_OF_COSTS,
       T.FINISH_OF_COST ,
       C.NAME CATEGORY,
       T.IMAGE,
       T.PLATFORM  ,
       T.CATEGORY_PLATFORM ,
       T.IMAGE_PLATFORM 
    FROM 
        (SELECT P.*, 
                PPL.PLATFORM,
                PPL.CATEGORY_PLATFORM,
                PPL.IMAGE_PLATFORM,
                PPL.DESCRIPTION_PLATFORM
            FROM
            U_DW_PRODUCTS.T_PRODUCTS P
            INNER JOIN
            (   SELECT PL.ID_PLATFORM,
                        PL.NAME PLATFORM,
                        CP.NAME CATEGORY_PLATFORM,
                        PL.IMAGE IMAGE_PLATFORM,
                        PL.DESCRIPTION DESCRIPTION_PLATFORM
                FROM 
                    U_DW_PRODUCTS.T_PLATFORM PL
                    INNER JOIN 
                    U_DW_PRODUCTS.T_CATEGORY_PLATFORM CP
                ON
                PL.ID_CATEGORY_PLATFORM=CP.ID_CATEGORY_PLATFORM
            ) PPL
            ON 
            P.ID_PLATFORM=PPL.ID_PLATFORM
            
        ) T
        INNER JOIN 
        U_DW_PRODUCTS.T_CATEGORY C
        ON 
        T.ID_CATEGORY=C.ID_CATEGORY';

    type PRODUCTS_tcur IS REF CURSOR;
    PRODUCTS_cur PRODUCTS_tcur;
    ID_PROD NUMBER;
    NAME CHAR(200 BYTE);
    START_OF_COSTS FLOAT;
    FINISH_OF_COST FLOAT;
    CATEGORY CHAR(50 BYTE);
    IMAGE VARCHAR2(10 BYTE);
    PLATFORM VARCHAR2(200 BYTE);
    CATEGORY_PLATFORM VARCHAR2(100 BYTE);
    IMAGE_PLATFORM VARCHAR2(200 BYTE);
    desctab   DBMS_SQL.DESC_TAB;
    curid NUMBER;
    colcnt  NUMBER;
 begin

 EXECUTE IMMEDIATE 'TRUNCATE TABLE U_DW_PRODUCTS.DIM_PRODUCTS';
 
 
    OPEN PRODUCTS_cur FOR SQL_QUERY;
    curid := DBMS_SQL.to_cursor_number (PRODUCTS_cur);  
    DBMS_SQL.DESCRIBE_COLUMNS(curid, colcnt, desctab);

    FOR i IN 1 .. colcnt LOOP
    
    dbms_output.put_line(desctab(i).col_type);
    dbms_output.put_line(desctab(i).col_max_len);
    dbms_output.put_line(desctab(i).col_name);
    
  END LOOP;
    
    DBMS_SQL.DEFINE_COLUMN(curid, 1, ID_PROD );
    DBMS_SQL.DEFINE_COLUMN(curid, 2, NAME, 200 );
    DBMS_SQL.DEFINE_COLUMN(curid, 3, START_OF_COSTS );
    DBMS_SQL.DEFINE_COLUMN(curid, 4, FINISH_OF_COST );
    DBMS_SQL.DEFINE_COLUMN(curid, 5, CATEGORY, 50 );
    DBMS_SQL.DEFINE_COLUMN(curid, 6, IMAGE, 100 );
    DBMS_SQL.DEFINE_COLUMN(curid, 7, PLATFORM, 200 );
    DBMS_SQL.DEFINE_COLUMN(curid, 8, CATEGORY_PLATFORM, 100 );
    DBMS_SQL.DEFINE_COLUMN(curid, 9, IMAGE_PLATFORM, 200 );

    WHILE DBMS_SQL.FETCH_ROWS(curid) > 0 LOOP
        DBMS_SQL.COLUMN_VALUE(curid, 1, ID_PROD );
        DBMS_SQL.COLUMN_VALUE(curid, 2, NAME );
        DBMS_SQL.COLUMN_VALUE(curid, 3, START_OF_COSTS );
        DBMS_SQL.COLUMN_VALUE(curid, 4, FINISH_OF_COST );
        DBMS_SQL.COLUMN_VALUE(curid, 5, CATEGORY );
        DBMS_SQL.COLUMN_VALUE(curid, 6, IMAGE );
        DBMS_SQL.COLUMN_VALUE(curid, 7, PLATFORM );
        DBMS_SQL.COLUMN_VALUE(curid, 8, CATEGORY_PLATFORM );
        DBMS_SQL.COLUMN_VALUE(curid, 9, IMAGE_PLATFORM );
    
        Insert into  U_DW_PRODUCTS.DIM_PRODUCTS 
            values 
            (
            ID_PROD,
               NAME ,
               START_OF_COSTS,
               FINISH_OF_COST ,
               CATEGORY,
               IMAGE ,
               PLATFORM  ,
               CATEGORY_PLATFORM ,
               IMAGE_PLATFORM  
               );
        COMMIT;

    END LOOP;
    

 IF DBMS_SQL.IS_OPEN( curid ) THEN
    DBMS_SQL.CLOSE_CURSOR( curid);
  end if;
 
END LOAD_DIM_PRODUCTS;


END pkg_ELT_DIM_PRODUCTS;
 
 
exec U_DW_PRODUCTS.pkg_ELT_DIM_PRODUCTS.LOAD_DIM_PRODUCTS;
```
