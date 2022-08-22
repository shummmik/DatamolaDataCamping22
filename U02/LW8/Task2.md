# Task 2

```sql
drop table U_DW_AUCTIONS.FCT_T_AUCTIONS_F cascade constraints;

/*==============================================================*/
/* Table: FCT_T_AUCTIONS_F                                      */
/*==============================================================*/
create table U_DW_AUCTIONS.FCT_T_AUCTIONS_F (
   ID_AUCTION           NUMBER                not null,
   ID_PROD              NUMBER,
   START_DTM            TIMESTAMP,
   FINISH_DTM           TIMESTAMP,
   DURATION             INTEGER,
   START_COST           FLOAT,
   COST                 FLOAT,
   SELLER               NUMBER(22),
   BUYER                NUMBER(22),
   ID_CURRENCY          NUMBER,
   DESCRIPTION          VARCHAR2(250),
   COMPLETE             SMALLINT             default 0,
   LOAD_DTM             TIMESTAMP            default SYSDATE,
   constraint PK_FCT_T_AUCTIONS_F primary key (ID_AUCTION, LOAD_DTM)
)
   tablespace TS_AUCTION_DATA_01;




drop table U_DW_AUCTIONS.FCT_T_BETS_F cascade constraints;

/*==============================================================*/
/* Table: FCT_T_BETS_F                                          */
/*==============================================================*/
create table U_DW_AUCTIONS.FCT_T_BETS_F (
   ID_USER              NUMBER                not null,
   ID_AUCTION           NUMBER                not null,
   MAKE_DTM             TIMESTAMP             not null,
   COST                 FLOAT,
   LOAD_DTM             TIMESTAMP            default SYSDATE,
   constraint PK_FCT_T_BETS_F primary key (ID_USER, ID_AUCTION, MAKE_DTM)
)
   tablespace TS_AUCTION_DATA_01;




drop table U_DW_SUBSTRICTIONS.FCT_T_SUBSCRIPTIONS_USER_F cascade constraints;

/*==============================================================*/
/* Table: FCT_T_SUBSCRIPTIONS_USER_F                            */
/*==============================================================*/
create table U_DW_SUBSTRICTIONS.FCT_T_SUBSCRIPTIONS_USER_F (
   ID_SUBSCRIPTIONS     NUMBER                not null,
   ID_USER              NUMBER                not null,
   PAYMENT              FLOAT,
   START_DTM            DATE                  not null,
   END_DTM              DATE,
   LOAD_DTM             TIMESTAMP            default SYSTIMESTAMP,
   ACTUAL_DTM           TIMESTAMP,
   constraint PK_FCT_T_SUBSCRIPTIONS_USER_F primary key (ID_SUBSCRIPTIONS, ID_USER, START_DTM, LOAD_DTM)
)
   tablespace TS_SUBSCRIPTION_DATA_01;



create or replace PACKAGE    U_DW_AUCTIONS.pkg_etl_AUCTIONS_FCT
AS  
   PROCEDURE load_FCT_T_BETS;
   
   PROCEDURE load_FCT_T_AUCTIONS;

END;



CREATE OR REPLACE PACKAGE body U_DW_AUCTIONS.pkg_etl_AUCTIONS_FCT
AS  
  PROCEDURE load_FCT_T_BETS
   AS
     BEGIN
     MERGE INTO U_DW_AUCTIONS.FCT_T_BETS_F FCT
     USING ( SELECT *
             FROM U_DW_AUCTIONS.T_BETS_F) F
             ON    (FCT.ID_USER=F.ID_USER
                AND FCT.ID_AUCTION=F.ID_AUCTION
                AND FCT.MAKE_DTM=F.MAKE_DTM)
             WHEN MATCHED THEN 
                UPDATE SET FCT.COST =F.COST,
                           FCT.LOAD_DTM = SYSDATE
             WHEN NOT MATCHED THEN 
                INSERT (FCT.ID_USER,
                        FCT.ID_AUCTION,
                       FCT.MAKE_DTM,
                       FCT.COST)
                VALUES (F.ID_USER,
                        F.ID_AUCTION,
                       F.MAKE_DTM,
                       F.COST);
     COMMIT;
   END load_FCT_T_BETS;
   
   
   
   PROCEDURE load_FCT_T_AUCTIONS
   AS
     BEGIN
     MERGE INTO U_DW_AUCTIONS.FCT_T_AUCTIONS_F FCT
     USING ( SELECT *
             FROM U_DW_AUCTIONS.T_AUCTIONS_F) F
             ON (FCT.ID_AUCTION=F.ID_AUCTION)
             WHEN MATCHED THEN 
                UPDATE SET FCT.ID_PROD =F.ID_PROD,
               FCT.START_DTM =F.START_DTM,
               FCT.FINISH_DTM =F.FINISH_DTM,
               FCT.DURATION =F.DURATION,
               FCT.START_COST =F.START_COST,
               FCT.COST =F.COST,
               FCT.SELLER =F.SELLER,
               FCT.BUYER =F.BUYER,
               FCT.ID_CURRENCY =F.ID_CURRENCY,
               FCT.DESCRIPTION =F.DESCRIPTION,
               FCT.COMPLETE  =F.COMPLETE,
               FCT.LOAD_DTM = SYSDATE
             WHEN NOT MATCHED THEN 
                INSERT (FCT.ID_AUCTION,
                        FCT.ID_PROD,
                       FCT.START_DTM,
                       FCT.FINISH_DTM,
                       FCT.DURATION,
                       FCT.START_COST,
                       FCT.COST,
                       FCT.SELLER,
                       FCT.BUYER,
                       FCT.ID_CURRENCY,
                       FCT.DESCRIPTION,
                       FCT.COMPLETE)
                VALUES (F.ID_AUCTION,
                        F.ID_PROD,
                       F.START_DTM,
                       F.FINISH_DTM,
                       F.DURATION,
                       F.START_COST,
                       F.COST,
                       F.SELLER,
                       F.BUYER,
                       F.ID_CURRENCY,
                       F.DESCRIPTION,
                       F.COMPLETE);
     COMMIT;
   END load_FCT_T_AUCTIONS;
END;




EXEC U_DW_AUCTIONS.pkg_etl_AUCTIONS_FCT.load_FCT_T_BETS;
EXEC U_DW_AUCTIONS.pkg_etl_AUCTIONS_FCT.load_FCT_T_AUCTIONS;



create or replace PACKAGE    U_DW_SUBSTRICTIONS.pkg_etl_SUBSCRIPTIONS_FCT
AS  
   PROCEDURE load_FCT_SUBSCRIPTIONS_USER;

END;






CREATE OR REPLACE PACKAGE body U_DW_SUBSTRICTIONS.pkg_etl_SUBSCRIPTIONS_FCT
AS  
  PROCEDURE load_FCT_SUBSCRIPTIONS_USER
   IS
    SELECT_TSU VARCHAR2(1000) := 'SELECT * FROM U_DW_SUBSTRICTIONS.T_SUBSCRIPTIONS_USER_F';
    SELECT_FTSU VARCHAR2(1000) := 'SELECT COUNT(*) FROM U_DW_SUBSTRICTIONS.FCT_T_SUBSCRIPTIONS_USER_F WHERE ID_SUBSCRIPTIONS=:IDS 
                                                                                    AND ID_USER=:IDU
                                                                                    AND START_DTM=:SD';
    SELECT_FTSU_ALL VARCHAR2(1000) := 'SELECT COUNT(*) FROM U_DW_SUBSTRICTIONS.FCT_T_SUBSCRIPTIONS_USER_F WHERE ID_SUBSCRIPTIONS=:1 
                                                                                    AND ID_USER=:2
                                                                                    AND PAYMENT=:3
                                                                                    AND START_DTM=:4
                                                                                    AND END_DTM=:5';
    UPDATE_FTSU_ALL VARCHAR2(1000) := 'UPDATE FCT_T_SUBSCRIPTIONS_USER_F 
                                     SET ACTUAL_DTM = SYSTIMESTAMP
                                      WHERE ID_SUBSCRIPTIONS=:1 
                                            AND ID_USER=:2
                                            AND PAYMENT=:3
                                            AND START_DTM=:4
                                            AND END_DTM=:5';
    type PRODUCTS_tcur IS REF CURSOR;
    PRODUCTS_cur PRODUCTS_tcur;
    
    ID_SUBSCRIPTIONS NUMBER;
    ID_USER NUMBER;
    PAYMENT FLOAT;
    START_DTM DATE;
    END_DTM DATE;

    
    desctab   DBMS_SQL.DESC_TAB;
    curid NUMBER;
    colcnt  NUMBER;
    COUNT_VALUES NUMBER :=0;
   
     BEGIN
     
        OPEN PRODUCTS_cur FOR SELECT_TSU;
        curid := DBMS_SQL.to_cursor_number (PRODUCTS_cur);  
        DBMS_SQL.DESCRIBE_COLUMNS(curid, colcnt, desctab);
    
        DBMS_SQL.DEFINE_COLUMN(curid, 1, ID_SUBSCRIPTIONS );
        DBMS_SQL.DEFINE_COLUMN(curid, 2, ID_USER);
        DBMS_SQL.DEFINE_COLUMN(curid, 3, PAYMENT );
        DBMS_SQL.DEFINE_COLUMN(curid, 4, START_DTM );
        DBMS_SQL.DEFINE_COLUMN(curid, 5, END_DTM);
        
        WHILE DBMS_SQL.FETCH_ROWS(curid) > 0 LOOP
            DBMS_SQL.COLUMN_VALUE(curid, 1, ID_SUBSCRIPTIONS );
            DBMS_SQL.COLUMN_VALUE(curid, 2, ID_USER );
            DBMS_SQL.COLUMN_VALUE(curid, 3, PAYMENT );
            DBMS_SQL.COLUMN_VALUE(curid, 4, START_DTM );
            DBMS_SQL.COLUMN_VALUE(curid, 5, END_DTM );
            
            
            EXECUTE IMMEDIATE SELECT_FTSU INTO COUNT_VALUES USING ID_SUBSCRIPTIONS, 
                                                                  ID_USER,
                                                                  START_DTM;
            IF COUNT_VALUES > 0 THEN
                EXECUTE IMMEDIATE SELECT_FTSU_ALL INTO COUNT_VALUES USING ID_SUBSCRIPTIONS, 
                                                                  ID_USER,
                                                                  PAYMENT,
                                                                  START_DTM ,
                                                                  END_DTM;
                 IF COUNT_VALUES < 1 THEN
                     EXECUTE IMMEDIATE UPDATE_FTSU_ALL USING ID_SUBSCRIPTIONS, 
                                                                  ID_USER,
                                                                  PAYMENT,
                                                                  START_DTM ,
                                                                  END_DTM;
                      COMMIT;
                    Insert into  U_DW_SUBSTRICTIONS.FCT_T_SUBSCRIPTIONS_USER_F ( ID_SUBSCRIPTIONS,
                                                                                   ID_USER ,
                                                                                   PAYMENT,
                                                                                   START_DTM ,
                                                                                   END_DTM)
                    values 
                    (  ID_SUBSCRIPTIONS,
                       ID_USER ,
                       PAYMENT,
                       START_DTM ,
                       END_DTM);
                     END IF;
            ELSE
                Insert into  U_DW_SUBSTRICTIONS.FCT_T_SUBSCRIPTIONS_USER_F ( ID_SUBSCRIPTIONS,
                                                                           ID_USER ,
                                                                           PAYMENT,
                                                                           START_DTM ,
                                                                           END_DTM)
                values 
                (  ID_SUBSCRIPTIONS,
                   ID_USER ,
                   PAYMENT,
                   START_DTM ,
                   END_DTM);
            END IF;
                
    
            
            COMMIT;

        END LOOP;
    

        IF DBMS_SQL.IS_OPEN( curid ) THEN
        DBMS_SQL.CLOSE_CURSOR( curid);
        end if;
        
   END load_FCT_SUBSCRIPTIONS_USER;
END;



EXEC U_DW_SUBSTRICTIONS.pkg_etl_SUBSCRIPTIONS_FCT.load_FCT_SUBSCRIPTIONS_USER;


```