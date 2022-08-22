
create or replace PACKAGE    U_DW_SUBSTRICTIONS.pkg_etl_SUBSCRIPTIONS_SAL
AS  
   PROCEDURE load_DIM_SUBSCRIPTIONS_SAL;

END;


CREATE OR REPLACE PACKAGE body U_DW_SUBSTRICTIONS.pkg_etl_SUBSCRIPTIONS_SAL
AS  
  PROCEDURE load_DIM_SUBSCRIPTIONS_SAL
   AS
    BEGIN
   
     UPDATE (
                SELECT 
                    SAL.END_DTM_UPD
                FROM 
                    (SELECT 
                        ID_SUBSCRIPTIONS_SAL,
                        ID_SUBSCRIPTIONS,
                        END_DTM_UPD 
                     FROM 
                        U_DW_SUBSTRICTIONS.DIM_SUBSCRIPTIONS_SAL 
                    WHERE 
                        END_DTM_UPD IS NULL) SAL
                 INNER JOIN
                    U_DW_SUBSTRICTIONS.DIM_SUBSCRIPTIONS DIM
                 ON 
                    SAL.ID_SUBSCRIPTIONS = DIM.ID_SUBSCRIPTIONS
            )

    SET
        END_DTM_UPD = SYSTIMESTAMP;
    COMMIT;    
    INSERT INTO U_DW_SUBSTRICTIONS.DIM_SUBSCRIPTIONS_SAL 
        (ID_SUBSCRIPTIONS , 
        NAME , 
        RATE , 
        DURATION_DAY , 
        DESCRIPTION , 
        START_DTM , 
        END_DTM )
    SELECT * 
    FROM 
     U_DW_SUBSTRICTIONS.DIM_SUBSCRIPTIONS;
     COMMIT;
  END load_DIM_SUBSCRIPTIONS_SAL;
END;


EXEC U_DW_SUBSTRICTIONS.pkg_etl_SUBSCRIPTIONS_SAL.load_DIM_SUBSCRIPTIONS_SAL;



create or replace PACKAGE    U_DW_PRODUCTS.pkg_etl_PRODUCTS_SAL
AS  
   PROCEDURE load_DIM_PRODUCTS_SAL;

END;



CREATE OR REPLACE PACKAGE body U_DW_PRODUCTS.pkg_etl_PRODUCTS_SAL
AS  
  PROCEDURE load_DIM_PRODUCTS_SAL
   AS
    BEGIN
   
     UPDATE (
                SELECT 
                    SAL.END_DTM_UPD
                FROM 
                    (SELECT 
                        ID_PROD,
                        END_DTM_UPD 
                     FROM 
                        U_DW_PRODUCTS.DIM_PRODUCTS_SAL 
                    WHERE 
                        END_DTM_UPD IS NULL) SAL
                 INNER JOIN
                    U_DW_PRODUCTS.DIM_PRODUCTS DIM
                 ON 
                    SAL.ID_PROD = DIM.ID_PROD
            )

    SET
        END_DTM_UPD = SYSTIMESTAMP;
    COMMIT;
    INSERT INTO U_DW_PRODUCTS.DIM_PRODUCTS_SAL 
        (ID_PROD , 
        NAME , 
        START_OF_COSTS , 
        FINISH_OF_COST , 
        CATEGORY , 
        IMAGE , 
        PLATFORM,
        CATEGORY_PLATFORM,
        IMAGE_PLATFORM)  
    SELECT * 
    FROM 
     U_DW_PRODUCTS.DIM_PRODUCTS;
     COMMIT;
  END load_DIM_PRODUCTS_SAL;
END;


EXEC U_DW_PRODUCTS.pkg_etl_PRODUCTS_SAL.load_DIM_PRODUCTS_SAL;




create or replace PACKAGE    U_DW_PERSONS.pkg_etl_PERSONS_SAL
AS  
   PROCEDURE load_DIM_BUYERS_SAL;
   PROCEDURE load_DIM_SELLERS_SAL;

END;


CREATE OR REPLACE PACKAGE body U_DW_PERSONS.pkg_etl_PERSONS_SAL
AS  
  PROCEDURE load_DIM_BUYERS_SAL
   AS
    BEGIN
   
     UPDATE (
                SELECT 
                    SAL.END_DTM_UPD
                FROM 
                    (SELECT 
                        ID_BUYERS,
                        END_DTM_UPD 
                     FROM 
                        U_DW_PERSONS.DIM_BUYERS_SAL 
                    WHERE 
                        END_DTM_UPD IS NULL) SAL
                 INNER JOIN
                    U_DW_PERSONS.DIM_BUYERS DIM
                 ON 
                    SAL.ID_BUYERS = DIM.ID_BUYERS
            )

    SET
        END_DTM_UPD = SYSTIMESTAMP;
    COMMIT;
    INSERT INTO U_DW_PERSONS.DIM_BUYERS_SAL 
        (ID_BUYERS , 
        F_NAME , 
        S_NAME , 
        PHONE , 
        EMAIL , 
        COUNTRY_ID , 
        CITY,
        STREET,
        IMAGE, 
        DATE_REG)  
    SELECT * 
    FROM 
     U_DW_PERSONS.DIM_BUYERS;
     COMMIT;
  END load_DIM_BUYERS_SAL;
  
  
  
  
  PROCEDURE load_DIM_SELLERS_SAL
   AS
    BEGIN
   
     UPDATE (
                SELECT 
                    SAL.END_DTM_UPD
                FROM 
                    (SELECT 
                        ID_SELLERS,
                        END_DTM_UPD 
                     FROM 
                        U_DW_PERSONS.DIM_SELLERS_SAL 
                    WHERE 
                        END_DTM_UPD IS NULL) SAL
                 INNER JOIN
                    U_DW_PERSONS.DIM_SELLERS DIM
                 ON 
                    SAL.ID_SELLERS = DIM.ID_SELLERS
            )

    SET
        END_DTM_UPD = SYSTIMESTAMP;
    COMMIT;
    INSERT INTO U_DW_PERSONS.DIM_SELLERS_SAL 
        (ID_SELLERS , 
        F_NAME , 
        S_NAME , 
        PHONE , 
        EMAIL , 
        COUNTRY_ID , 
        CITY,
        STREET,
        IMAGE, 
        DATE_REG)  
    SELECT * 
    FROM 
     U_DW_PERSONS.DIM_SELLERS;
     COMMIT;
  END load_DIM_SELLERS_SAL;
END;




GRANT SELECT, READ  ON U_DW_PRODUCTS.DIM_PRODUCTS_SAL  to U_DW_AUCTIONS;
GRANT SELECT, READ  ON  U_DW_PERSONS.DIM_BUYERS_SAL  to U_DW_AUCTIONS;
GRANT SELECT, READ  ON U_DW_PERSONS.DIM_SELLERS_SAL   to U_DW_AUCTIONS;


EXEC U_DW_PERSONS.pkg_etl_PERSONS_SAL.load_DIM_BUYERS_SAL;
EXEC U_DW_PERSONS.pkg_etl_PERSONS_SAL.load_DIM_SELLERS_SAL;