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
GameNotFound EXCEPTION;
BEGIN
    IF region = 'arg' THEN
        SELECT COUNT(*) INTO cnt FROM GAME WHERE App_ID = appid;

        IF cnt = 0 THEN
            RAISE GameNotFound;
        END IF;
        SELECT MAX(PID) INTO cnt FROM PRICING ORDER BY PID DESC;
        cnt := cnt + 1;
        INSERT INTO PRICING VALUES(cnt,discount,price,region, ratings ,appid);
    ELSIF region = 'bd' THEN
        dbms_output.put_line('bd regions');
    END IF;

    EXCEPTION
        WHEN GameNotFound THEN
            dbms_output.put_line('GAME FOR THE GIVEN APPID DOESNT EXIST');

END;
/