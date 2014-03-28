SET SERVEROUTPUT ON



/*
DECLARE
   findPrime int := 600851475143;
   currentDivisor int := 600851475142;
   subDivisor int := 0;
   resultNumber int :=0;
BEGIN
      WHILE resultNumber = 0
        LOOP
                IF mod(findPrime, currentDivisor)=0 THEN
                         subDivisor := currentDivisor;
                         WHILE subDivisor > 1
                         LOOP
                           subDivisor := subDivisor-1;
                           IF mod(currentDivisor, subDivisor) = 0 THEN
                             subDivisor := 1;
                           END IF;
                           IF subDivisor = 2 AND mod(currentDivisor, subDivisor) != 0 THEN
                            resultNumber := currentDivisor;
                           END IF;
                        END LOOP;
                END IF;
      -- dbms_output.put_line(to_char(currentDivisor));                  
        END LOOP; 
      dbms_output.put_line(to_char(resultNumber));   
END;
/*
/*
SET SERVEROUTPUT ON
DECLARE
   message  varchar2(20):= 'Hello, Worldddd!';
   counter int := 0;
   outputResult int := 0;
BEGIN
    -- AUFGABE 1
    WHILE counter < 1000
    LOOP
      IF mod(counter, 3) = 0 OR mod(counter, 5) = 0 THEN
      outputResult := outputResult + counter;
      END IF;
      counter := counter+1;
    END LOOP;
    dbms_output.put_line(message);
    dbms_output.put_line(outputResult);
END;
*/

/*
SET SERVEROUTPUT ON
DECLARE
   firstNumber int := 1;
   secondNumber int := 2;
   temporaryResult int :=0;
   resultNumber int := 0;
BEGIN

    WHILE resultNumber < 4000000
    LOOP
      temporaryResult := firstNumber+secondNumber;
      firstNumber := secondNumber;
      secondNumber := temporaryResult;
      IF mod(temporaryResult, 2) = 0 THEN
       resultNumber := resultNumber+temporaryResult;     
      END IF;
   -- dbms_output.put_line(to_char(temporaryResult));
    END LOOP; 
    resultNumber := resultNumber+2;
    dbms_output.put_line(to_char(resultNumber));   
END;
*/