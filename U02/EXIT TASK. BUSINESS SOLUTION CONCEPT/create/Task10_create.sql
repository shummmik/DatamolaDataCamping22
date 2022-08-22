drop table U_DW_SUBSTRICTIONS.DIM_SUBSCRIPTIONS_SAL cascade constraints;


  CREATE TABLE U_DW_SUBSTRICTIONS.DIM_SUBSCRIPTIONS_SAL 
   ( ID_SUBSCRIPTIONS_SAL NUMBER GENERATED ALWAYS AS IDENTITY,
    ID_SUBSCRIPTIONS NUMBER, 
	NAME VARCHAR2(50 BYTE), 
	RATE FLOAT(126), 
	DURATION_DAY NUMBER, 
	DESCRIPTION VARCHAR2(200 BYTE), 
	START_DTM DATE, 
	END_DTM DATE,
    
    START_DTM_UPD TIMESTAMP    default SYSTIMESTAMP, 
	END_DTM_UPD TIMESTAMP,
    CONSTRAINT PK_DIM_PRODUCTS_SAL PRIMARY KEY (ID_SUBSCRIPTIONS_SAL)
   ) TABLESPACE TS_SUBSCRIPTION_DATA_01 ;




drop table U_DW_PRODUCTS.DIM_PRODUCTS_SAL cascade constraints;


  CREATE TABLE U_DW_PRODUCTS.DIM_PRODUCTS_SAL 
   ( ID_PROD_SAL NUMBER GENERATED ALWAYS AS IDENTITY,
    ID_PROD NUMBER, 
	NAME CHAR(200 BYTE), 
	START_OF_COSTS FLOAT(126), 
	FINISH_OF_COST FLOAT(126), 
	CATEGORY CHAR(50 BYTE), 
	IMAGE VARCHAR2(100 BYTE), 
	PLATFORM VARCHAR2(200 BYTE), 
	CATEGORY_PLATFORM VARCHAR2(100 BYTE), 
	IMAGE_PLATFORM VARCHAR2(200 BYTE), 
        
    START_DTM_UPD TIMESTAMP            default SYSTIMESTAMP, 
	END_DTM_UPD TIMESTAMP,
	 CONSTRAINT PK_DIM_PRODUCTS_SAL PRIMARY KEY (ID_PROD_SAL)
   ) 
  TABLESPACE TS_PRODUCT_DATA_01 ;



drop table U_DW_PERSONS.DIM_SELLERS_SAL cascade constraints;


  CREATE TABLE U_DW_PERSONS.DIM_SELLERS_SAL
   ( ID_SELLERS_SAL NUMBER GENERATED ALWAYS AS IDENTITY,
   ID_SELLERS NUMBER(22,0), 
	F_NAME CHAR(100 BYTE), 
	S_NAME CHAR(100 BYTE), 
	PHONE CHAR(15 BYTE), 
	EMAIL CHAR(50 BYTE), 
	COUNTRY_ID CHAR(200 BYTE), 
	CITY CHAR(50 BYTE), 
	STREET CHAR(300 BYTE), 
	IMAGE CHAR(200 BYTE), 
	DATE_REG TIMESTAMP (6), 
        
    START_DTM_UPD TIMESTAMP            default SYSTIMESTAMP, 
	END_DTM_UPD TIMESTAMP,
	 CONSTRAINT PK_DIM_SELLERS_SAL PRIMARY KEY (ID_SELLERS_SAL)
   )  TABLESPACE TS_PRODUCT_DATA_01 ;




drop table U_DW_PERSONS.DIM_BUYERS_SAL cascade constraints;


  CREATE TABLE U_DW_PERSONS.DIM_BUYERS_SAL
   ( ID_BUYERS_SAL NUMBER GENERATED ALWAYS AS IDENTITY, 
    ID_BUYERS NUMBER(22,0), 
	F_NAME CHAR(100 BYTE), 
	S_NAME CHAR(100 BYTE), 
	PHONE CHAR(15 BYTE), 
	EMAIL CHAR(50 BYTE), 
	COUNTRY_ID CHAR(200 BYTE), 
	CITY CHAR(50 BYTE), 
	STREET CHAR(300 BYTE), 
	IMAGE CHAR(200 BYTE), 
	DATE_REG TIMESTAMP (6), 
        
    START_DTM_UPD TIMESTAMP            default SYSTIMESTAMP, 
	END_DTM_UPD TIMESTAMP,
	 CONSTRAINT PK_DIM_BUYERS_SAL PRIMARY KEY (ID_BUYERS_SAL)
   )  TABLESPACE TS_PRODUCT_DATA_01 ;
