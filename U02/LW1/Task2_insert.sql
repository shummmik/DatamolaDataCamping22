--T_ADDRESS_TYPES

INSERT INTO U_DW_REFERENCES.T_ADDRESS_TYPES VALUES (2, 'WORK', 'WORK');
INSERT INTO U_DW_REFERENCES.T_ADDRESS_TYPES VALUES (1, 'HOME', 'HOME');
commit;

--T_ADDRESES
--T_USER
declare
num_fname NUMBER ;
num_sname NUMBER ;
fname varchar2(10);
sname varchar2(10);
BEGIN
     FOR i IN 1..90000 LOOP

        insert into U_DW_REFERENCES.T_ADDRESSES  values (
                                i, 
                                TRUNC(DBMS_Random.Value(1,2)), 
                                TRUNC(DBMS_Random.Value(1,235)), 
                                '220100', 
                                TRUNC(DBMS_Random.Value(1,35)), 
                                TRUNC(DBMS_Random.Value(1,123)), 
                                TRUNC(DBMS_Random.Value(1,413)), 
                                TRUNC(DBMS_Random.Value(1,817)), 
                                TO_CHAR(TRUNC(DBMS_Random.Value(1,40))), 
                                TO_CHAR(TRUNC(DBMS_Random.Value(1,1278)))
                                );
        commit;
        num_fname := (mod(TRUNC(DBMS_Random.Value(1,1000)), 7)+1) ;
        num_sname := (mod(TRUNC(DBMS_Random.Value(1,1000)), 7)+1) ;
        select c.name into fname from (select 1 as r, 'Paul' as name from dual
                                                    union all 
                                                    select 2 , 'Adam'  from dual
                                                    union all 
                                                    select 3 , 'Natalia' from dual
                                                    union all 
                                                    select 4 , 'Tanya' from dual
                                                    union all 
                                                    select 5 , 'Genya' from dual
                                                    union all 
                                                    select 6 , 'Fox' from dual
                                                     union all 
                                                    select 7 , 'Alex' from dual
                                                    ) c where c.r=num_fname;
                                                    
        select b.name into sname from (select 1 as r, 'Mulder' as name from dual
                                 union all 
                                select 2 , 'Vazovski'  from dual
                                union all 
                                select 3 , 'Telehany' from dual
                                union all 
                                select 4 , 'Book' from dual
                                union all 
                                select 5 , 'Gen' from dual
                                union all 
                                select 6 , 'Glass' from dual
                                union all 
                                select 7 , 'Taras' from dual
                                )  b where b.r =num_sname;

        insert into U_DW_PERSONS.T_USER (ID_USER, ID_ADDRES, F_NAME, S_NAME, PHONE, EMAIL, DATE_REG, IMAGE)  values (
                                i, 
                                i, 
                                fname,
                                sname,
                                '375251234567', 
                                'mail@mail.ru', 
                                TO_DATE('01/08/2021', 'DD/MM/YYYY') + TRUNC(DBMS_Random.Value(-500,350)),  
                                'IMAGE'
                                );
        commit;
    END LOOP;
END;

--T_CATEGORY

INSERT INTO U_DW_PRODUCTS.T_CATEGORY VALUES (3, 'Pets');
INSERT INTO U_DW_PRODUCTS.T_CATEGORY VALUES (2, 'Amulets');
INSERT INTO U_DW_PRODUCTS.T_CATEGORY VALUES (5, 'Clothers');
INSERT INTO U_DW_PRODUCTS.T_CATEGORY VALUES (4, 'Potions');
INSERT INTO U_DW_PRODUCTS.T_CATEGORY VALUES (1, 'Weapons');
commit;

--T_CATEGORY_PLATFORM
INSERT INTO U_DW_PRODUCTS.T_CATEGORY_PLATFORM VALUES (2, 'WEB');
INSERT INTO U_DW_PRODUCTS.T_CATEGORY_PLATFORM VALUES (3, 'XBOX');
INSERT INTO U_DW_PRODUCTS.T_CATEGORY_PLATFORM VALUES (1, 'PC');
commit;
--T_CURRENCY

  CREATE TABLE "U_DW_EXT_REFERENCES"."T_EXT_CURRENCY_ISO4217" 
   (	"ENTITY" VARCHAR2(50 CHAR), 
	"CURRENCY" VARCHAR2(20 CHAR), 
	"ALPHABETICCODE" VARCHAR2(5 CHAR), 
	"NUMERICCODE" NUMBER, 
	"MINORUNIT" VARCHAR2(2 CHAR), 
	"WITHDRAWALDATE" VARCHAR2(20 CHAR)
   ) 
   ORGANIZATION EXTERNAL 
    ( TYPE ORACLE_LOADER
      DEFAULT DIRECTORY "EXT_REFERENCES"
      ACCESS PARAMETERS
      ( RECORDS DELIMITED BY NEWLINE NOBADFILE NODISCARDFILE NOLOGFILE FIELDS TERMINATED BY ',' MISSING FIELD VALUES ARE NULL( entity,
    currency  , alphabeticCode  , numericCode  , minorUnit  , withdrawalDate  ) )
      LOCATION
       ( 'codes-all.csv'
       )
    );

insert into U_DW_AUCTIONS.T_CURRENCY select distinct numericCode, currency, alphabeticCode from u_dw_ext_references.t_ext_currency_iso4217 where minorUnit is not NULL;
commit;

--T_PLATFORM

INSERT INTO U_DW_PRODUCTS.T_PLATFORM values (1, 'Game1', 2, 'image', 'DESCRIPTION');
INSERT INTO U_DW_PRODUCTS.T_PLATFORM values (2, 'Game2', 2, 'image', 'DESCRIPTION');
INSERT INTO U_DW_PRODUCTS.T_PLATFORM values (3, 'Game3', 2, 'image', 'DESCRIPTION');
INSERT INTO U_DW_PRODUCTS.T_PLATFORM values (4, 'Game4', 2, 'image', 'DESCRIPTION');
INSERT INTO U_DW_PRODUCTS.T_PLATFORM values (5, 'Game5', 2, 'image', 'DESCRIPTION');
INSERT INTO U_DW_PRODUCTS.T_PLATFORM values (6, 'Game6', 2, 'image', 'DESCRIPTION');
INSERT INTO U_DW_PRODUCTS.T_PLATFORM values (7, 'dance', 1, 'image', 'DESCRIPTION');
INSERT INTO U_DW_PRODUCTS.T_PLATFORM values (8, 'gun', 1, 'image', 'DESCRIPTION');
INSERT INTO U_DW_PRODUCTS.T_PLATFORM values (9, 'drive', 1, 'image', 'DESCRIPTION');
INSERT INTO U_DW_PRODUCTS.T_PLATFORM values (10, 'nfs', 1, 'image', 'DESCRIPTION');
INSERT INTO U_DW_PRODUCTS.T_PLATFORM values (11, 'rpg', 1, 'image', 'DESCRIPTION');
INSERT INTO U_DW_PRODUCTS.T_PLATFORM values (12, 'XBOX_game1', 3, 'image', 'DESCRIPTION');
INSERT INTO U_DW_PRODUCTS.T_PLATFORM values (13, 'XBOX_game2', 3, 'image', 'DESCRIPTION');
INSERT INTO U_DW_PRODUCTS.T_PLATFORM values (14, 'XBOX_game3', 3, 'image', 'DESCRIPTION');
INSERT INTO U_DW_PRODUCTS.T_PLATFORM values (15, 'XBOX_game4', 3, 'image', 'DESCRIPTION');
INSERT INTO U_DW_PRODUCTS.T_PLATFORM values (16, 'XBOX_game5', 3, 'image', 'DESCRIPTION');
INSERT INTO U_DW_PRODUCTS.T_PLATFORM values (17, 'XBOX_game6', 3, 'image', 'DESCRIPTION');
commit;


--T_PRODUCTS
BEGIN
     FOR i IN 1..100000 LOOP
        INSERT INTO U_DW_PRODUCTS.T_PRODUCTS values (I, 
                                        SUBSTR('NAME_NAME_NAME', TRUNC(DBMS_Random.Value(-4,4)), TRUNC(DBMS_Random.Value(4,14))),
                                        TRUNC(DBMS_Random.Value(1,17)),
                                        TRUNC(DBMS_Random.Value(1,50), 2),
                                        TRUNC(DBMS_Random.Value(51,150), 2), 
                                        'DESCRIPTION',
                                        TRUNC(DBMS_Random.Value(1,5)) ,
                                        'image');
        commit;
    END LOOP;
END;

--T_SUBSCRIPTIONS_NAME

INSERT INTO U_DW_SUBSTRICTIONS.T_SUBSCRIPTIONS_NAME VALUES (1, 'START');
INSERT INTO U_DW_SUBSTRICTIONS.T_SUBSCRIPTIONS_NAME VALUES (2, 'MEDIUM');
INSERT INTO U_DW_SUBSTRICTIONS.T_SUBSCRIPTIONS_NAME VALUES (3, 'PREMIUM');
INSERT INTO U_DW_SUBSTRICTIONS.T_SUBSCRIPTIONS_NAME VALUES (4, 'YEAR');
COMMIT;

--T_SUBSCRIPTIONS

INSERT INTO U_DW_SUBSTRICTIONS.T_SUBSCRIPTIONS VALUES (1, 1,  DBMS_Random.Value(1,17), 30, 'DESCRIPTION', TO_DATE('01-02-2021', 'DD-MM-YYYY'), TO_DATE('31-07-2021', 'DD-MM-YYYY'));
INSERT INTO U_DW_SUBSTRICTIONS.T_SUBSCRIPTIONS VALUES (2, 1,  DBMS_Random.Value(1,17), 30, 'DESCRIPTION', TO_DATE('01-08-2021', 'DD-MM-YYYY'), TO_DATE('01-10-2021', 'DD-MM-YYYY'));
INSERT INTO U_DW_SUBSTRICTIONS.T_SUBSCRIPTIONS (ID_SUBSCRIPTIONS, ID_SUBSCRIPTIONS_NAME, RATE, DURATION_DAY, DESCRIPTION, START_DTM) VALUES (3, 1,  DBMS_Random.Value(1,17), 30, 'DESCRIPTION', TO_DATE('02-10-2021', 'DD-MM-YYYY'));
INSERT INTO U_DW_SUBSTRICTIONS.T_SUBSCRIPTIONS VALUES (4, 2,  DBMS_Random.Value(1,17), 30, 'DESCRIPTION', TO_DATE('01-02-2021', 'DD-MM-YYYY'), TO_DATE('31-07-2021', 'DD-MM-YYYY'));
INSERT INTO U_DW_SUBSTRICTIONS.T_SUBSCRIPTIONS VALUES (5, 2,  DBMS_Random.Value(1,17), 30, 'DESCRIPTION', TO_DATE('01-08-2021', 'DD-MM-YYYY'), TO_DATE('01-10-2021', 'DD-MM-YYYY'));
INSERT INTO U_DW_SUBSTRICTIONS.T_SUBSCRIPTIONS (ID_SUBSCRIPTIONS, ID_SUBSCRIPTIONS_NAME, RATE, DURATION_DAY, DESCRIPTION, START_DTM) VALUES (6, 2,  DBMS_Random.Value(1,17), 30, 'DESCRIPTION', TO_DATE('02-10-2021', 'DD-MM-YYYY'));
INSERT INTO U_DW_SUBSTRICTIONS.T_SUBSCRIPTIONS VALUES (7, 3,  DBMS_Random.Value(1,17), 30, 'DESCRIPTION', TO_DATE('01-02-2021', 'DD-MM-YYYY'), TO_DATE('01-08-2021', 'DD-MM-YYYY'));
INSERT INTO U_DW_SUBSTRICTIONS.T_SUBSCRIPTIONS VALUES (8, 3,  DBMS_Random.Value(1,17), 30, 'DESCRIPTION', TO_DATE('01-08-2021', 'DD-MM-YYYY'), TO_DATE('01-10-2021', 'DD-MM-YYYY'));
INSERT INTO U_DW_SUBSTRICTIONS.T_SUBSCRIPTIONS VALUES (9, 3,  DBMS_Random.Value(1,17), 30, 'DESCRIPTION', TO_DATE('02-10-2021', 'DD-MM-YYYY'), TO_DATE('01-03-2022', 'DD-MM-YYYY'));
INSERT INTO U_DW_SUBSTRICTIONS.T_SUBSCRIPTIONS (ID_SUBSCRIPTIONS, ID_SUBSCRIPTIONS_NAME, RATE, DURATION_DAY, DESCRIPTION, START_DTM) VALUES (10, 3,  DBMS_Random.Value(1,17), 30, 'DESCRIPTION', TO_DATE('02-03-2022', 'DD-MM-YYYY'));
INSERT INTO U_DW_SUBSTRICTIONS.T_SUBSCRIPTIONS VALUES (11, 4,  DBMS_Random.Value(1,17), 30, 'DESCRIPTION', TO_DATE('01-02-2021', 'DD-MM-YYYY'), TO_DATE('01-08-2021', 'DD-MM-YYYY'));
INSERT INTO U_DW_SUBSTRICTIONS.T_SUBSCRIPTIONS VALUES (12, 4,  DBMS_Random.Value(1,17), 30, 'DESCRIPTION', TO_DATE('01-08-2021', 'DD-MM-YYYY'), TO_DATE('01-10-2021', 'DD-MM-YYYY'));
INSERT INTO U_DW_SUBSTRICTIONS.T_SUBSCRIPTIONS (ID_SUBSCRIPTIONS, ID_SUBSCRIPTIONS_NAME, RATE, DURATION_DAY, DESCRIPTION, START_DTM) VALUES  (13, 4,  DBMS_Random.Value(1,17), 30, 'DESCRIPTION', TO_DATE('02-10-2021', 'DD-MM-YYYY'));
COMMIT;
(ID_SUBSCRIPTIONS, ID_SUBSCRIPTIONS_NAME, RATE, DURATION_DAY, DESCRIPTION, START_DTM)

--T_SUBSCRIPTIONS_USER_F

insert into U_DW_SUBSTRICTIONS.T_SUBSCRIPTIONS_USER_F
select  c.ID_SUBSCRIPTIONS,  
       TRUNC(DBMS_Random.Value(1,90000)) as ID_USER,
       TRUNC(t.RATE *(1 + TRUNC(DBMS_Random.Value(1,15))/100),2) as PAYMENT,
       case
        when t.end_dtm-t.START_DTM is Null
            then
                t.START_DTM + mod(c.rn, TO_DATE('01-08-2022', 'DD-MM-YYYY')-t.START_DTM)
        else
            t.START_DTM + mod(c.rn, t.end_dtm-t.START_DTM)
        END  as START_DTM,
       case
        when t.end_dtm-t.START_DTM is Null
            then
                t.START_DTM + mod(c.rn, TO_DATE('01-08-2022', 'DD-MM-YYYY')-t.START_DTM) + t.DURATION_DAY
        else
            t.START_DTM + mod(c.rn, t.end_dtm-t.START_DTM) + t.DURATION_DAY 
        END as END_DTM

 from      
    (SELECT ROWNUM rn, TRUNC(DBMS_Random.Value(1,13)) as ID_SUBSCRIPTIONS FROM dual CONNECT BY level <= 350000) c
    inner join
    U_DW_SUBSTRICTIONS.T_SUBSCRIPTIONS t
    on t.ID_SUBSCRIPTIONS=c.ID_SUBSCRIPTIONS;

commit;
--T_AUCTIONS_F

insert into U_DW_AUCTIONS.T_AUCTIONS_F 
select  c.rn as ID_AUCTION,  
        c.ID_PROD,
        c.START_DTM,
        c.START_DTM + c.DURATION as FINISH_DTM,
        c.DURATION,
        c.START_COST,
        TRUNC(c.START_COST* DBMS_Random.Value(1,10), 2) as COST, 
        TRUNC(DBMS_Random.Value(1,90000)) as SELLER, 
        TRUNC(DBMS_Random.Value(1,90000)) as BUYER, 
	    840 ID_CURRENCY, 
        'DESCRIPTION' as DESCRIPTION, 
        TRUNC(DBMS_Random.Value(1,3))-1 as COMPLETE
        
 from      
    (SELECT ROWNUM rn, 
                TRUNC(DBMS_Random.Value(1,100000)) as ID_PROD, 
                TO_DATE('01/08/2021', 'DD/MM/YYYY') + TRUNC(DBMS_Random.Value(-500,350)) as START_DTM,
                TRUNC(DBMS_Random.Value(5,30)) as DURATION,
                TRUNC(DBMS_Random.Value(10,150)) as START_COST 
                
                FROM dual CONNECT BY level <= 400000) c;
commit;
