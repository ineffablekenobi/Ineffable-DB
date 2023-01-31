SET VERIFY OFF;
SET SERVEROUTPUT ON;
PROMPT
PROMPT INSERT TO PRICING
PROMPT

DECLARE

appid NUMBER := &appid;
discount NUMBER := &discount;
price NUMBER := &price;
region VARCHAR(200) := &region;
ratings NUMBER := &ratings;

cnt NUMBER;
cnt1 NUMBER;
GameNotFound EXCEPTION;
BEGIN

    SELECT COUNT(*) INTO cnt FROM GAME WHERE App_ID = appid;

    IF cnt = 0 THEN
        RAISE GameNotFound;
    END IF;
    SELECT MAX(PID) INTO cnt FROM PRICING ORDER BY PID DESC;
    SELECT MAX(PID) INTO cnt1 FROM PRICING@site_link ORDER BY PID DESC;
    IF cnt1 > cnt THEN
        cnt := cnt1;
    END IF;
    cnt := cnt + 1;
    
    IF region = 'bd' THEN
        INSERT INTO PRICING VALUES(cnt,discount,price,region, ratings ,appid);
    ELSIF region = 'arg' THEN
        INSERT INTO PRICING@site_link VALUES(cnt,discount,price,region, ratings ,appid);
    END IF;

    EXCEPTION
        WHEN GameNotFound THEN
            dbms_output.put_line('GAME FOR THE GIVEN APPID DOESNT EXIST');

END;
/