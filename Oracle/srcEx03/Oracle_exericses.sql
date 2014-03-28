--List tables
select table_name from user_tables;

--1. Setup
DROP TABLE AbtStatistik;
CREATE TABLE AbtStatistik (
  AbtNr          INTEGER PRIMARY KEY,
  Name           CHAR(20),
  SalaerSumme    DECIMAL (8,2),
  AnzMa          INTEGER,
  FOREIGN KEY (AbtNr) REFERENCES Abteilung
  ON DELETE CASCADE
);

--2. Fill AbtStatistik with Data
INSERT INTO AbtStatistik(AbtNr, Name, SalaerSumme, anzma)
SELECT abt.abtnr, abt.name, SUM(ang.Salaer), count(ang.persnr)
FROM abteilung abt
      INNER JOIN angestellter ang ON abt.abtnr = ang.abtnr
group by abt.abtnr, abt.name;

--3. Checking Initial Inserts:
SELECT * FROM AbtStatistik;

--4. Trigger
DROP TRIGGER updateStatisticsAngestellter;

CREATE OR REPLACE TRIGGER updateStatisticsAngestellter
AFTER DELETE OR INSERT OR UPDATE ON angestellter
BEGIN
    DROP TABLE AbtStatistik;
    CREATE TABLE AbtStatistik (
      AbtNr          INTEGER PRIMARY KEY,
      Name           CHAR(20),
      SalaerSumme    DECIMAL (8,2),
      AnzMa          INTEGER,
      FOREIGN KEY (AbtNr) REFERENCES Abteilung
      ON DELETE CASCADE
    );
    INSERT INTO AbtStatistik(AbtNr, Name, SalaerSumme, anzma)
    SELECT abt.abtnr, abt.name, SUM(ang.Salaer), count(ang.persnr)
    FROM abteilung abt
          INNER JOIN angestellter ang ON abt.abtnr = ang.abtnr
    group by abt.abtnr, abt.name
END;

DROP TRIGGER updateStatisticsAbteilung;

CREATE OR REPLACE TRIGGER updateStatisticsAbteilung
AFTER DELETE OR INSERT OR UPDATE ON abteilung
BEGIN
    DROP TABLE AbtStatistik;
    CREATE TABLE AbtStatistik (
      AbtNr          INTEGER PRIMARY KEY,
      Name           CHAR(20),
      SalaerSumme    DECIMAL (8,2),
      AnzMa          INTEGER,
      FOREIGN KEY (AbtNr) REFERENCES Abteilung
      ON DELETE CASCADE
    );
    INSERT INTO AbtStatistik(AbtNr, Name, SalaerSumme, anzma)
    SELECT abt.abtnr, abt.name, SUM(ang.Salaer), count(ang.persnr)
    FROM abteilung abt
          INNER JOIN angestellter ang ON abt.abtnr = ang.abtnr
    group by abt.abtnr, abt.name
END;

-- 5 Testing the triggers -- Note2Self: "" are forbidden, use '' instead
DELETE FROM angestellter WHERE TEL = 301;
SELECT * FROM angestellter;