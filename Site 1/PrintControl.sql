SET VERIFY OFF;
SET SERVEROUTPUT ON;
PROMPT
PROMPT Welcome To INEFFABLE DB
PROMPT
PROMPT TO SEE ALL VALUES OF THE PRICING TABLE IN ALL SITE, ENTER 1
PROMPT TO SEE ALL VALUES OF THE PRICING TABLE IN THIS SITE, ENTER 2

-- Pricing Control -> pc
CREATE OR REPLACE PACKAGE pc AS
    PROCEDURE printGlobal;
    PROCEDURE printLocal;
    

END pc;
/

CREATE OR REPLACE PACKAGE BODY pc AS


    PROCEDURE printGlobal IS
    BEGIN

        printLocal();

    END printGlobal;
    
    PROCEDURE printLocal IS

    BEGIN

        FOR rec IN (SELECT * FROM PRICING) LOOP
        dbms_output.put_line(rec.PID || ' ' || rec.Discount || ' ' || rec.Price || ' ' || rec.Region || ' ' || rec.Ratings || ' ' || rec.App_id);
        END LOOP;

    END printLocal;

   

END pc;
/

CREATE OR REPLACE PROCEDURE RouteRequest AS
        query number := &query;
    BEGIN

        IF query = 1 THEN
            pc.printGlobal();
        ELSIF query = 2 THEN
            pc.printGlobal();
        
        END IF;
        
    END RouteRequest;
/

DECLARE

BEGIN
    
    RouteRequest();
END;
/