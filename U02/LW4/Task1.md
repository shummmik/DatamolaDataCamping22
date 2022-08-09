#Task 1

```sql
create or replace PACKAGE                     U_DW_PRODUCTS.pkg_ELT_DIM_PRODUCTS
AS  
   PROCEDURE LOAD_DIM_PRODUCTS;

END pkg_ELT_DIM_PRODUCTS;



create or replace PACKAGE BODY                     U_DW_PRODUCTS.pkg_ELT_DIM_PRODUCTS
AS

   PROCEDURE LOAD_DIM_PRODUCTS
   IS

   cursor CL is
       SELECT 
        T.ID_PROD,
       T.NAME,
       T.START_OF_COSTS,
       T.FINISH_OF_COST ,
       T.DESCRIPTION ,
       C.NAME CATEGORY,
       T.IMAGE ,
       T.PLATFORM  ,
       T.CATEGORY_PLATFORM ,
       T.IMAGE_PLATFORM  ,
       T.DESCRIPTION_PLATFORM 
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
        T.ID_CATEGORY=C.ID_CATEGORY;
        
        TYPE ROWS_TABLE_TYPE IS TABLE OF CL%ROWTYPE; 
       R_TABLE ROWS_TABLE_TYPE;
   BEGIN
   
    EXECUTE IMMEDIATE 'TRUNCATE TABLE u_dw_ext_references.CLS_CALENDAR';
    OPEN CL;
    
    LOOP
        FETCH CL BULK COLLECT INTO R_TABLE  LIMIT 100;
        
        IF CL%NOTFOUND
        THEN
        EXIT;
        
        END IF;
         FORALL i IN INDICES OF R_TABLE
        Insert into  U_DW_PRODUCTS.DIM_PRODUCTS 
        values 
        (
        R_TABLE(i).ID_PROD,
           R_TABLE(i).NAME,
           R_TABLE(i).START_OF_COSTS,
           R_TABLE(i).FINISH_OF_COST ,
           R_TABLE(i).CATEGORY,
           R_TABLE(i).IMAGE ,
           R_TABLE(i).PLATFORM  ,
           R_TABLE(i).CATEGORY_PLATFORM ,
           R_TABLE(i).IMAGE_PLATFORM  );
        COMMIT;
    END LOOP;
    CLOSE CL;
   END LOAD_DIM_PRODUCTS;


END pkg_ELT_DIM_PRODUCTS;

```

![Table](t1.png "Table")