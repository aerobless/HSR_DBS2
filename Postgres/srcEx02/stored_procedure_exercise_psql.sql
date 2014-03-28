-- Einfache PL/pgsql-Funktion, welche die Abteilungsnummer zurückgibt, gegeben die Angestellten-Nummer.
DROP FUNCTION IF EXISTS ProjektZuteilen(int, int);
CREATE OR REPLACE FUNCTION ProjektZuteilen(_pkAngestellter IN angestellter.persnr%TYPE,
					    _pkProjekt IN projekt.projnr%TYPE,
					    _prozArbeitszeit INT,
					    _startZeit DATE DEFAULT current_date) RETURNS void  -- RETURNS void falls Prozedur!
AS $$
DECLARE
	bereitsBeiProjekt int;
	totaleArbeitsZeit int= 0;
BEGIN
	--Vorbedingungen überprüfen
	IF _prozArbeitszeit < 10 or _prozArbeitszeit > 90 THEN
		RAISE NOTICE 'Arbeitszeit sollte zwischen 10 und 90 sein';
		RAISE SQLSTATE '22012';
	END IF;
	SELECT sum(persnr) INTO bereitsBeiProjekt FROM projektzuteilung WHERE persnr = _pkAngestellter AND projnr = _pkProjekt;
	IF bereitsBeiProjekt >= 1 THEN
		RAISE NOTICE 'Mitarbeiter bereits dem Projekt zugewiesen';
		RAISE SQLSTATE '22012';
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
END; 
$$ LANGUAGE plpgsql;

-- Test-Aufrufe:
SELECT ProjektZuteilen(1002, 25, 12);
-- Test der failt weil Person bereits zugewiesen:
-- SELECT ProjektZuteilen(1001, 30, 19);