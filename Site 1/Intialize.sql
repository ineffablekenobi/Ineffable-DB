DROP TABLE GAME CASCADE CONSTRAINTS;
DROP TABLE PRICING CASCADE CONSTRAINTS;

CREATE TABLE GAME(App_ID NUMBER PRIMARY KEY,
 TITLE VARCHAR(200),
 App_Type VARCHAR(200), 
 Developer VARCHAR(200), 
 Publisher VARCHAR(200), 
 Supported_Systems VARCHAR(200), 
 Release_Date DATE);

 CREATE TABLE PRICING(PID NUMBER PRIMARY KEY, 
 Discount NUMBER, 
 Price NUMBER, 
 Region VARCHAR(200), 
 Ratings NUMBER, 
 App_id NUMBER);

INSERT INTO GAME VALUES(1, 'ASSASSINS CREED UNITY','ACTION','UBISOFT MONTREAL','UBISOFT','WINDOWS,MAC','01-Feb-23');
INSERT INTO PRICING VALUES(1, 10, 49, 'arg', 5, 1);


commit;

CREATE OR REPLACE PROCEDURE PrintPricing AS

BEGIN
    FOR rec IN (SELECT * FROM PRICING) LOOP
        dbms_output.put_line(rec.PID || ' ' || rec.Discount || ' ' || rec.Price || ' ' || rec.Region || ' ' || rec.Ratings || ' ' || rec.App_id);
        END LOOP;

        FOR rec IN (SELECT * FROM PRICING@site_link) LOOP
        dbms_output.put_line(rec.PID || ' ' || rec.Discount || ' ' || rec.Price || ' ' || rec.Region || ' ' || rec.Ratings || ' ' || rec.App_id);
        END LOOP;


END;
/

CREATE OR REPLACE TRIGGER PricingInsertTrigger 
AFTER INSERT ON PRICING
BEGIN
    dbms_output.put_line('');
    dbms_output.put_line('ENTRY CREATED');
    dbms_output.put_line('');
    PrintPricing();
END;
/


