SET SERVEROUTPUT ON
CREATE OR REPLACE PROCEDURE ProjektZuteilen(_pkAngestellter IN angestellter.persnr%TYPE,
					    _pkProjekt IN projekt.projnr%TYPE,
					    _prozArbeitszeit INT,
					    _startZeit DATE DEFAULT sysdate)
IS
	bereitsBeiProjekt int :=0;
	totaleArbeitsZeit int :=0;
  PRAGMA EXCEPTION_INIT( ex_custom, -20001 );
BEGIN
	--Vorbedingungen überprüfen
	IF _prozArbeitszeit < 10 or _prozArbeitszeit > 90 THEN
    raise_application_error(-20001, 'Arbeitszeit sollte zwischen 10 und 90 sein');
	END IF;
	SELECT sum(persnr) INTO bereitsBeiProjekt FROM projektzuteilung WHERE persnr = _pkAngestellter AND projnr = _pkProjekt;
	IF bereitsBeiProjekt >= 1 THEN
    raise_application_error(-20001, 'Mitarbeiter bereits dem Projekt zugewiesen');
	END IF;
	SELECT sum(zeitanteil) INTO totaleArbeitsZeit FROM projektzuteilung WHERE persnr = _pkAngestellter GROUP BY persnr;
	totaleArbeitsZeit = totaleArbeitsZeit + _prozArbeitszeit;
	IF totaleArbeitsZeit > 100 THEN
		RAISE NOTICE 'Arbeitszeit überschritten mit % Prozent, Mitarbeiter ist bereits voll ausgelastet', totaleArbeitsZeit;
		RAISE SQLSTATE '22012';
	END IF;
	
	--Operation durchführen:
	INSERT INTO projektzuteilung (persnr, projnr, zeitanteil, startzeit)
	VALUES (_pkAngestellter, _pkProjekt, _prozArbeitszeit, _startZeit);
	RAISE NOTICE 'Stored procedure successful';
EXCEPTION;
END; 

-- Test-Aufrufe:
-- SELECT ProjektZuteilen(1002, 25, 12);
-- Test der failt weil Person bereits zugewiesen:
-- SELECT ProjektZuteilen(1001, 30, 19);